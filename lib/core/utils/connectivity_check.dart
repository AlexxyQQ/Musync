import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/core/network/hive/hive_queries.dart';

class ConnectivityCheck {
  static Future<bool> connectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return false;
    }
  }

  static Future<bool> isServerup({bool recheck = false}) async {
    try {
      if (recheck) {
        final api = GetIt.instance.get<Api>();
        final response = await api.sendRequest.get(
          ApiEndpoints.baseRoute,
        );
        ApiResponse responseApi = ApiResponse.fromResponse(response);
        if (responseApi.success) {
          await GetIt.instance<HiveQueries>().setValue(
            boxName: 'users',
            key: 'server',
            value: true,
          );
          return true;
        } else {
          return false;
        }
      } else {
        return await GetIt.instance<HiveQueries>()
            .getValue(boxName: 'users', key: 'server', defaultValue: false);
      }
    } catch (e) {
      return false;
    }
  }
}

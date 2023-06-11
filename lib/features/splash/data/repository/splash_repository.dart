import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/use_case/auth_use_case.dart';
import 'package:musync/features/splash/domain/repository/splash_repository.dart';

class SplashRepository extends ASplashRepository {
  @override
  Future<ErrorModel> checkConnectivityAndServer() async {
    var isConnected = await isConnectedToInternet();
    var server = await isServerUp();
    log('isConnected: ${isConnected.status}');
    log('server: ${server.status}');
    if (isConnected.status) {
      if (!server.status) {
        return ErrorModel(
          status: false,
          message: 'Server is down.',
        );
      } else {
        return ErrorModel(
          status: true,
          message: 'Server is up.',
        );
      }
    } else {
      return ErrorModel(
        status: false,
        message: 'No internet connection.',
      );
    }
  }

  @override
  Future<ErrorModel> isConnectedToInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return ErrorModel(
        status: true,
        message: 'Connected to a mobile network.',
      );
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return ErrorModel(
        status: true,
        message: 'Connected to a wifi network.',
      );
    } else if (connectivityResult == ConnectivityResult.none) {
      return ErrorModel(
        status: false,
        message: 'No internet connection.',
      );
    } else {
      return ErrorModel(
        status: false,
        message: 'Unknown error.',
      );
    }
  }

  @override
  Future<ErrorModel> isServerUp() async {
    final api = GetIt.instance.get<Api>();
    try {
      final response = await api.sendRequest.get(
        '/',
      );
      ApiResponse responseApi = ApiResponse.fromResponse(response);
      if (responseApi.success) {
        return ErrorModel(
          status: true,
          message: 'Server is up.',
        );
      } else {
        return ErrorModel(
          status: false,
          message: 'Server is down.',
        );
      }
    } catch (e) {
      return ErrorModel(
        status: false,
        message: 'Server is down.',
      );
    }
  }

  @override
  Future<ErrorModel> getLoggeduser({
    bool isFirstTime = false,
    bool goHome = false,
  }) async {
    isFirstTime = await GetIt.instance<HiveQueries>().getValue(
      boxName: 'settings',
      key: "isFirstTime",
      defaultValue: true,
    );
    goHome = await GetIt.instance<HiveQueries>().getValue(
      boxName: 'settings',
      key: "goHome",
      defaultValue: false,
    );
    final String token = await GetIt.instance<HiveQueries>()
        .getValue(boxName: 'users', key: 'token', defaultValue: '');

    if (token == "") {
      return ErrorModel(
        status: false,
        message: 'No user logged in.',
        data: {
          'isFirstTime': isFirstTime,
          'goHome': goHome,
        },
      );
    } else {
      try {
        // Get userentity from token
        final authUseCase = GetIt.instance.get<AuthUseCase>();
        UserEntity user = await authUseCase.initialLogin(token: token);
        return ErrorModel(
          status: true,
          message: 'User logged in.',
          data: {
            'isFirstTime': isFirstTime,
            'goHome': goHome,
            'user': user,
          },
        );
      } catch (e) {
        return ErrorModel(
          status: false,
          message: 'No user logged in.',
          data: {
            'isFirstTime': isFirstTime,
            'goHome': goHome,
          },
        );
      }
    }
  }
}

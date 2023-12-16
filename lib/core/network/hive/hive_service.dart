import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/features/home/data/data_source/local_data_source/hive_service/query_hive_service.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/hive/hive_service/setting_hive_service.dart';

class HiveService {
  Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    await SettingsHiveService().init();
    await QueryHiveService().init();
  }

  /// Open Hive Boxes
  /// Provide a {$boxName} to open, if it fails to open, it will try again
  Future<void> hiveOpen(String boxName) async {
    await Hive.openBox(boxName).onError(
      (error, stackTrace) async {
        await Hive.openBox(boxName);
        throw 'Failed to open $boxName Box\nError: $error';
      },
    );
  }
}

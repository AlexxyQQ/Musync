import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/config/constants/hive/hive_tabel_constant.dart';
import 'package:musync/core/common/hive/app_settings_hive_model.dart';

class SettingsHiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppSettingsHiveModelAdapter());
  }

  // ------------------ All Settings Queries ------------------ //

  Future<void> addSettings(AppSettingsHiveModel settings) async {
    var box = await Hive.openBox<AppSettingsHiveModel>(
      HiveTableConstant.appSettingsBox,
    );

    await box.put(0, settings);
  }

  Future<AppSettingsHiveModel> getSettings() async {
    var box = await Hive.openBox<AppSettingsHiveModel>(
      HiveTableConstant.appSettingsBox,
    );
    final data = box.values;
    if (data.isEmpty) {
      addSettings(AppSettingsHiveModel.empty());
      return AppSettingsHiveModel.empty();
    } else {
      return data.first;
    }
  }

  Future<void> updateSettings(AppSettingsHiveModel settings) async {
    var box = await Hive.openBox<AppSettingsHiveModel>(
      HiveTableConstant.appSettingsBox,
    );
    await box.putAt(0, settings);
  }
}

// Future<void> addSettings(AppSettingsHiveModel settings) async {
//   log('SettingsHiveService: getSettings: $settings');
//   await _settingsBox?.add(settings);
// }

// Future<AppSettingsHiveModel> getSettings() async {
//   final data = _settingsBox?.values;
//   log('SettingsHiveService: getSettings: $data');
//   if (data == null) {
//     return AppSettingsHiveModel(
//       firstTime: true,
//       goHome: false,
//       server: false,
//       token: null,
//     );
//   } else {
//     return AppSettingsHiveModel.empty();
//   }
// }

// Future<void> updateSettings(AppSettingsHiveModel settings) async {
//   await _settingsBox?.putAt(0, settings);
// }

// Future<void> deleteSettings() async {
//   await _settingsBox?.delete(0);
// }

// Future<void> clearSettings() async {
//   await _settingsBox?.clear();
// }

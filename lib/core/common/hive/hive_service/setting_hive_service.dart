import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/core/common/hive/app_settings_hive_model.dart';

class SettingsHiveService {
  Box<AppSettingsHiveModel>? _settingsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppSettingsHiveModelAdapter());

    _settingsBox = await Hive.openBox<AppSettingsHiveModel>(
      HiveTableConstant.appSettingsBox,
    );

    await addSettings(AppSettingsHiveModel.empty());
  }

  // ------------------ All Settings Queries ------------------ //

  Future<void> addSettings(AppSettingsHiveModel settings) async {
    log('SettingsHiveService: getSettings: $settings');
    await _settingsBox?.add(settings);
  }

  Future<AppSettingsHiveModel> getSettings() async {
    final data = _settingsBox?.values;
    log('SettingsHiveService: getSettings: $data');
    if (data == null) {
      return AppSettingsHiveModel(
        firstTime: true,
        goHome: false,
        server: false,
        token: null,
      );
    } else {
      return AppSettingsHiveModel.empty();
    }
  }

  Future<void> updateSettings(AppSettingsHiveModel settings) async {
    await _settingsBox?.putAt(0, settings);
  }

  Future<void> deleteSettings() async {
    await _settingsBox?.delete(0);
  }

  Future<void> clearSettings() async {
    await _settingsBox?.clear();
  }
}

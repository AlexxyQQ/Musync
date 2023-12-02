import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/core/common/app_settings_hive_model.dart';

class SettingsHiveService {
  Box<AppSettingsHiveModel>? _settingsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppSettingsHiveModelAdapter());

    _settingsBox = await Hive.openBox<AppSettingsHiveModel>(
      HiveTableConstant.appSettingsBox,
    );
  }

  // ------------------ All Settings Queries ------------------ //
  Future<AppSettingsHiveModel> getSettings() async {
    final data = _settingsBox?.get(0) ?? AppSettingsHiveModel.empty();
    // if firsttime is true then set it to false
    if (data.firstTime) {
      await updateSettings(data.copyWith(firstTime: false));
    }

    return data;
  }

  Future<void> updateSettings(AppSettingsHiveModel settings) async {
    await _settingsBox?.put(0, settings);
  }

  Future<void> deleteSettings() async {
    await _settingsBox?.delete(0);
  }

  Future<void> clearSettings() async {
    await _settingsBox?.clear();
  }
}

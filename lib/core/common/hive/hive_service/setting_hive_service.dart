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

  void clearSettings() {}
}

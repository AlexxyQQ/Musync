import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/core/common/hive_service/setting_hive_service.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../core/network/api/api.dart';
import '../core/utils/connectivity_check.dart';
import '../features/auth/injection/auth_injection_container.dart';
import '../features/home/injection/home_injection_container.dart';
import '../features/splash/injection/splash_injection_container.dart';

final get = GetIt.instance;

void setupDependencyInjection() {
  SplashInjectionContainer().register();
  AuthInjectionContainer().register();
  HomeInjectionContainer().register();

  // GetIt.instance.registerLazySingleton(() => HiveQueries());
  GetIt.instance.registerLazySingleton(() => OnAudioQuery());
  GetIt.instance.registerLazySingleton(() => Api());
  GetIt.instance.registerLazySingleton(() => AudioPlayer());
  GetIt.instance.registerLazySingleton(() => ConnectivityCheck());
  GetIt.instance.registerLazySingleton(() => SettingsHiveService());
}

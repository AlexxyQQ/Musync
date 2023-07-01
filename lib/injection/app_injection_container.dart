import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/coreold/repositories/audio_player_repository.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/auth/injection/auth_injection_container.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/features/home/injection/music_query_injection_container.dart';
import 'package:musync/features/splash/injection/splash_injection_container.dart';
import 'package:on_audio_query/on_audio_query.dart';

void setupDependencyInjection() {
  AuthInjectionContainer().register();
  SplashInjectionContainer().register();
  MusicQueryInjectionContainer().register();
  GetIt.instance.registerLazySingleton(() => HiveQueries());
  GetIt.instance.registerLazySingleton(() => OnAudioQuery());
  GetIt.instance.registerLazySingleton(() => Api());
  GetIt.instance.registerLazySingleton(() => AudioPlayer());
  GetIt.instance.registerLazySingleton(
    () => AudioPlayerRepository(
      audioPlayer: GetIt.instance<AudioPlayer>(),
    ),
  );
}
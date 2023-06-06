import 'package:get_it/get_it.dart';
import 'package:musync/core/repositories/local_storage_repository.dart';
import 'package:musync/core/repositories/music_repositories.dart';
import 'package:musync/core/repositories/user_repositories.dart';
import 'package:musync/core/services/api/api.dart';
import 'package:on_audio_query/on_audio_query.dart';

void setupDependencyInjection() {
  GetIt.instance.registerLazySingleton(() => LocalStorageRepository());
  GetIt.instance.registerLazySingleton(() => OnAudioQuery());
  GetIt.instance.registerLazySingleton(() => Api());
  GetIt.instance.registerLazySingleton(
    () => UserRepositories(
      api: GetIt.instance<Api>(),
    ),
  );

  GetIt.instance.registerLazySingleton(
    () => MusicRepository(
      localStorage: GetIt.instance<LocalStorageRepository>(),
      audioQuery: GetIt.instance<OnAudioQuery>(),
    ),
  );
}

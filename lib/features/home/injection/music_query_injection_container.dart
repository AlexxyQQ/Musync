import 'package:get_it/get_it.dart';
import 'package:musync/features/home/data/data_source/music_hive_data_source.dart';
import 'package:musync/features/home/data/data_source/music_local_data_source.dart';
import 'package:musync/features/home/data/repository/music_query_repositories.dart';
import 'package:musync/features/home/domain/repository/music_query_repository_a.dart';
import 'package:musync/features/home/domain/use_case/music_query_use_case.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicQueryInjectionContainer {
  var get = GetIt.instance;

  void register() {
    get.registerLazySingleton(
      () => MusicHiveDataSourse(),
    );
    get.registerLazySingleton(
      () => MusicLocalDataSource(),
    );
    get.registerLazySingleton<IMusicQueryRepository>(
      () => MusicQueryRepositoryImpl(
        musicLocalDataSource: get<MusicLocalDataSource>(),
        onaudioQuery: get<OnAudioQuery>(),
      ),
    );
    get.registerLazySingleton<MusicQueryRepositoryImpl>(
      () => MusicQueryRepositoryImpl(
        musicLocalDataSource: get<MusicLocalDataSource>(),
        onaudioQuery: get<OnAudioQuery>(),
      ),
    );
    get.registerLazySingleton(
      () => MusicQueryUseCase(
        musicQueryRepository: get<MusicQueryRepositoryImpl>(),
      ),
    );
  }
}

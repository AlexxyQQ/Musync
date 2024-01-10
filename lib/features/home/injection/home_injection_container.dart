import 'package:musync/features/home/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:musync/features/home/domain/usecase/get_recently_played_usecase.dart';
import 'package:musync/features/home/domain/usecase/update_song_usecase.dart';

import '../../../injection/app_injection_container.dart';
import '../data/data_source/local_data_source/hive_service/query_hive_service.dart';
import '../data/data_source/local_data_source/local_data_source.dart';
import '../data/data_source/query_data_source.dart';
import '../data/repository/audio_query_repository_impl.dart';
import '../domain/repository/audio_query_repository.dart';
import '../domain/usecase/get_all_albums_usecase.dart';
import '../domain/usecase/get_all_artist_usecase.dart';
import '../domain/usecase/get_all_folders_usecase.dart';
import '../domain/usecase/get_all_songs_usecase.dart';
import '../presentation/cubit/query_cubit.dart';

class HomeInjectionContainer {
  void register() {
    // Hive Service
    get.registerLazySingleton(
      () => QueryHiveService(),
    );

    // Data Sources
    get.registerLazySingleton(
      () => AudioQueryLocalDataSource(
        onAudioQuery: get(),
      ),
    );
    get.registerLazySingleton(
      () => AudioQueryRemoteDataSource(
        api: get(),
      ),
    );

    get.registerLazySingleton<IAudioQueryDataSource>(
      () => AudioQueryDataSourceImpl(
        localDataSource: get(),
        queryHiveService: get(),
        remoteDataSource: get(),
      ),
    );

    get.registerLazySingleton<AudioQueryDataSourceImpl>(
      () => AudioQueryDataSourceImpl(
        localDataSource: get(),
        queryHiveService: get(),
        remoteDataSource: get(),
      ),
    );

    // Repository
    get.registerLazySingleton<IAudioQueryRepository>(
      () => AudioQueryRepositiryImpl(
        audioQueryDataSource: get(),
        audioQueryDataSourceImpl: get(),
      ),
    );

    // Use Cases
    get.registerLazySingleton(
      () => GetAllSongsUseCase(
        audioQueryRepository: get(),
        queryHiveService: get(),
        settingsHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => GetAllAlbumsUsecase(
        audioQueryRepository: get(),
        settingsHiveService: get(),
        queryHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => GetAllArtistsUsecase(
        audioQueryRepository: get(),
        settingsHiveService: get(),
        queryHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => GetAllFoldersUsecase(
        audioQueryRepository: get(),
        settingsHiveService: get(),
        queryHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => GetRecentlyPlayedUsecase(
        queryHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => UpdateRecentlyPlayedUsecase(
        queryHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => UpdateSongUsecase(
        settingsHiveService: get(),
        audioQueryRepository: get(),
      ),
    );

    // Cubit
    get.registerFactory(
      () => QueryCubit(
        getAllSongsUseCase: get(),
        getAllAlbumsUsecase: get(),
        getAllArtistsUsecase: get(),
        getAllFoldersUsecase: get(),
        settingsHiveService: get(),
        queryHiveService: get(),
        getRecentlyPlayedUsecase: get(),
        updateRecentlyPlayedUsecase: get(),
        updateSongUsecase: get(),
      ),
    );
  }
}

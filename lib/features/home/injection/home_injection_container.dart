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

    get.registerLazySingleton<IAudioQueryDataSource>(
      () => AudioQueryDataSourceImpl(
        localDataSource: get(),
        queryHiveService: get(),
      ),
    );

    // Repository
    get.registerLazySingleton<IAudioQueryRepository>(
      () => AudioQueryRepositiryImpl(
        audioQueryDataSource: get(),
      ),
    );

    // Use Cases
    get.registerLazySingleton(
      () => GetAllSongsUseCase(
        audioQueryRepository: get(),
        queryHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => GetAllAlbumsUsecase(
        audioQueryRepository: get(),
        queryHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => GetAllArtistsUsecase(
        audioQueryRepository: get(),
        queryHiveService: get(),
      ),
    );
    get.registerLazySingleton(
      () => GetAllFoldersUsecase(
        audioQueryRepository: get(),
        queryHiveService: get(),
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
      ),
    );
  }
}

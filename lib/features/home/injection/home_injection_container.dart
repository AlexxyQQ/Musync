import '../../../injection/app_injection_container.dart';
import '../data/data_source/local_data_source/hive_service/query_hive_service.dart';
import '../data/data_source/local_data_source/local_data_source.dart';
import '../data/data_source/query_data_source.dart';
import '../data/repository/audio_query_repository_impl.dart';
import '../domain/repository/audio_query_repository.dart';
import '../domain/usecase/get_songs_usecase.dart';
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
      () => GetSongsUseCase(
        audioQueryRepository: get(),
        queryHiveService: get(),
      ),
    );

    // Cubit
    get.registerFactory(
      () => QueryCubit(
        getSongsUseCase: get(),
        settingsHiveService: get(),
      ),
    );
  }
}

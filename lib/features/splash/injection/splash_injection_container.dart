import 'package:get_it/get_it.dart';
import '../data/data_source/splash_remote_data_source.dart';
import '../data/repository/splash_repository.dart';
import '../domain/repository/splash_repository.dart';
import '../domain/use_case/splash_use_case.dart';

class SplashInjectionContainer {
  var get = GetIt.instance;

  void register() {
    // Data Source
    get.registerLazySingleton(
      () => SplashRemoteDataSource(
        api: get(),
      ),
    );
    // Repository
    get.registerLazySingleton<ISplashRepository>(
      () => SplashRepositoryImpl(
        splashRemoteDataSource: get<SplashRemoteDataSource>(),
      ),
    );
    // Use Case
    get.registerLazySingleton(
      () => InitialLoginUseCase(
        splashRepository: get(),
        settingsHiveService: get(),
      ),
    );
  }
}

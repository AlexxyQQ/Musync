import 'package:get_it/get_it.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/splash/data/data_source/splash_remote_data_source.dart';
import 'package:musync/features/splash/data/repository/splash_repository.dart';
import 'package:musync/features/splash/domain/use_case/splash_use_case.dart';

class SplashInjectionContainer {
  var get = GetIt.instance;

  void register() {
    get.registerLazySingleton(
      () => SplashRemoteDataSource(
        api: get<Api>(),
      ),
    );
    get.registerLazySingleton(
      () => SplashRepositoryImpl(
        splashRemoteDataSource: get<SplashRemoteDataSource>(),
      ),
    );
    get.registerLazySingleton(
      () => SplashUseCase(
        splashRepository: get<SplashRepositoryImpl>(),
        hiveQueries: get<HiveQueries>(),
      ),
    );
  }
}

import 'package:get_it/get_it.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/features/auth/data/data_source/auth_data_source.dart';
import 'package:musync/features/auth/data/repository/auth_repository.dart';
import 'package:musync/features/auth/domain/use_case/auth_use_case.dart';

class AuthInjectionContainer {
  var get = GetIt.instance;

  void register() {
    get.registerLazySingleton(
      () => AuthDataSource(
        api: get<Api>(),
      ),
    );
    get.registerLazySingleton(
      () => AuthRepositoryImpl(
        authDataSource: get<AuthDataSource>(),
      ),
    );
    get.registerLazySingleton(
      () => AuthUseCase(
        authRepository: get<AuthRepositoryImpl>(),
      ),
    );
  }
}

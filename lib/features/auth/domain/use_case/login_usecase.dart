import 'package:dartz/dartz.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final IAuthRepository repository;
  final HiveQueries hiveQueries;

  LoginUseCase({
    required this.repository,
    required this.hiveQueries,
  });

  @override
  Future<Either<AppErrorHandler, UserEntity>> call(LoginParams params) async {
    final data = await repository.login(
      email: params.email,
      password: params.password,
    );

    return data.fold((l) => Left(l), (r) async {
      await hiveQueries.setValue(
        boxName: 'users',
        key: 'token',
        value: r.token,
      );
      return Right(r);
    });
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

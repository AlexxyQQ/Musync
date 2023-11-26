import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase({
    required this.repository,
  });

  @override
  Future<Either<ErrorModel, UserEntity>> call(LoginParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
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

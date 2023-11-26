import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class SignupUseCase extends UseCase<UserEntity, SignupParams> {
  final IAuthRepository repository;

  SignupUseCase({
    required this.repository,
  });

  @override
  Future<Either<ErrorModel, UserEntity>> call(SignupParams params) async {
    return await repository.signup(
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class SignupParams {
  final String username;
  final String email;
  final String password;

  SignupParams({
    required this.username,
    required this.email,
    required this.password,
  });
}
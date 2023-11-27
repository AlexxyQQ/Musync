import 'package:dartz/dartz.dart';
import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class SignupUseCase extends UseCase<UserEntity, SignupParams> {
  final IAuthRepository repository;

  SignupUseCase({
    required this.repository,
  });

  @override
  Future<Either<AppErrorHandler, UserEntity>> call(SignupParams params) async {
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

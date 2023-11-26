import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class GoogleLoginUseCase extends UseCase<UserEntity, void> {
  final IAuthRepository repository;

  GoogleLoginUseCase({
    required this.repository,
  });

  @override
  Future<Either<ErrorModel, UserEntity>> call(void params) async {
    return await repository.googleLogin();
  }
}

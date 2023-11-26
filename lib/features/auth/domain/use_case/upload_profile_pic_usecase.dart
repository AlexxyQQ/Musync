import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class UploadProfilePicUseCase
    extends UseCase<UserEntity, UploadProfilePicParams> {
  final IAuthRepository repository;

  UploadProfilePicUseCase({
    required this.repository,
  });

  @override
  Future<Either<ErrorModel, UserEntity>> call(
    UploadProfilePicParams params,
  ) async {
    return await repository.uploadProfilePic(
      profilePicPath: params.profilePicPath,
      token: params.token,
    );
  }
}

class UploadProfilePicParams {
  final String profilePicPath;
  final String token;

  UploadProfilePicParams({
    required this.profilePicPath,
    required this.token,
  });
}

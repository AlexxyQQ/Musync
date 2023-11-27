import 'package:dartz/dartz.dart';
import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UploadProfilePicUseCase
    extends UseCase<UserEntity, UploadProfilePicParams> {
  final IAuthRepository repository;

  UploadProfilePicUseCase({
    required this.repository,
  });

  @override
  Future<Either<AppErrorHandler, UserEntity>> call(
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

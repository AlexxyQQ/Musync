import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';

abstract class IAuthRepository {
  Future<Either<ErrorModel, UserEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<ErrorModel, UserEntity>> signup({
    required String email,
    required String password,
    required String username,
  });
  Future<Either<ErrorModel, UserEntity>> googleLogin();
  Future<Either<ErrorModel, void>> logout();
  Future<Either<ErrorModel, bool>> checkDeviceSupportForBiometrics();

  Future<Either<ErrorModel, UserEntity>> uploadProfilePic({
    required String token,
    required String profilePicPath,
  });

  Future<Either<ErrorModel, bool>> deleteUser({
    required String token,
  });
}

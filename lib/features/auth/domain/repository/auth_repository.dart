import 'package:dartz/dartz.dart';

import '../../../../core/failure/error_handler.dart';
import '../entity/user_entity.dart';

abstract class IAuthRepository {
  Future<Either<AppErrorHandler, UserEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<AppErrorHandler, UserEntity>> signup({
    required String email,
    required String password,
    required String username,
  });
  Future<Either<AppErrorHandler, void>> logout();

  Future<Either<AppErrorHandler, UserEntity>> uploadProfilePic({
    required String token,
    required String profilePicPath,
  });

  Future<Either<AppErrorHandler, bool>> deleteUser({
    required String token,
  });
  Future<Either<AppErrorHandler, bool>> signupOTPValidator({
    required String email,
    required String otp,
  });
  Future<Either<AppErrorHandler, bool>> forgotPasswordOTPSender({
    required String email,
  });
  Future<Either<AppErrorHandler, bool>> forgotPasswordOTPValidator({
    required String email,
    required String otp,
    required String newPassword,
  });
}

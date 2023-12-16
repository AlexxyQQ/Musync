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
  Future<Either<AppErrorHandler, bool>> sendForgotPasswordOTP({
    required String email,
  });
  Future<Either<AppErrorHandler, bool>> chagePassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmNewPassword,
  });
  Future<Either<AppErrorHandler, bool>> resendVerification({
    required String token,
  });
}

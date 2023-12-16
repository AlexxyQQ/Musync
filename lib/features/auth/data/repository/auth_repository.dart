import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';

import '../../domain/repository/auth_repository.dart';
import '../data_source/remote_data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final AuthRemoteDataSource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });

  @override
  Future<Either<AppErrorHandler, bool>> deleteUser({
    required String token,
  }) async {
    return await authDataSource.deleteUser(token: token);
  }

  @override
  Future<Either<AppErrorHandler, bool>> sendForgotPasswordOTP({
    required String email,
  }) async {
    return await authDataSource.sendForgotPasswordOTP(
      email: email,
    );
  }

  @override
  Future<Either<AppErrorHandler, bool>> chagePassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    return await authDataSource.chagePassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
  }

  @override
  Future<Either<AppErrorHandler, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    return await authDataSource.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<AppErrorHandler, void>> logout() async {
    return await authDataSource.logout();
  }

  @override
  Future<Either<AppErrorHandler, UserEntity>> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    return await authDataSource.signup(
      email: email,
      password: password,
      username: username,
    );
  }

  @override
  Future<Either<AppErrorHandler, bool>> signupOTPValidator({
    required String email,
    required String otp,
  }) async {
    return await authDataSource.signupOTPValidator(
      email: email,
      otp: otp,
    );
  }

  @override
  Future<Either<AppErrorHandler, UserEntity>> uploadProfilePic({
    required String token,
    required String profilePicPath,
  }) async {
    return await authDataSource.uploadProfilePic(
      token: token,
      profilePicPath: profilePicPath,
    );
  }

  @override
  Future<Either<AppErrorHandler, bool>> resendVerification({
    required String token,
  }) {
    return authDataSource.resendVerification(token: token);
  }
}

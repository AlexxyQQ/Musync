import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class ChangePasswordUsecase extends UseCase<bool, ChagePasswordParams> {
  final IAuthRepository repository;

  ChangePasswordUsecase({
    required this.repository,
  });

  @override
  Future<Either<AppErrorHandler, bool>> call(params) async {
    return await repository.chagePassword(
      email: params.email,
      otp: params.otp,
      newPassword: params.newPassword,
      confirmNewPassword: params.confirmNewPassword,
    );
  }
}

class ChagePasswordParams {
  final String email;
  final String otp;
  final String newPassword;
  final String confirmNewPassword;

  ChagePasswordParams({
    required this.email,
    required this.otp,
    required this.newPassword,
    required this.confirmNewPassword,
  });
}

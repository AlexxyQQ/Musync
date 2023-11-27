import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class ForgotPasswordOTPValidatorUsecase
    extends UseCase<bool, ForgotPasswordOTPValidatorParams> {
  final IAuthRepository repository;

  ForgotPasswordOTPValidatorUsecase({
    required this.repository,
  });

  @override
  Future<Either<AppErrorHandler, bool>> call(params) async {
    return await repository.forgotPasswordOTPValidator(
      email: params.email,
      otp: params.otp,
      newPassword: params.newPassword,
    );
  }
}

class ForgotPasswordOTPValidatorParams {
  final String email;
  final String otp;
  final String newPassword;

  ForgotPasswordOTPValidatorParams({
    required this.email,
    required this.otp,
    required this.newPassword,
  });
}

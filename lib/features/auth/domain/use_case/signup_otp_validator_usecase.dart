import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/usecase/usecase.dart';

class OTPValidatorUsecase extends UseCase<bool, SignupOTPValidatorParams> {
  final IAuthRepository repository;

  OTPValidatorUsecase({
    required this.repository,
  });

  @override
  Future<Either<AppErrorHandler, bool>> call(params) async {
    return await repository.signupOTPValidator(
      email: params.email,
      otp: params.otp,
    );
  }
}

class SignupOTPValidatorParams {
  final String email;
  final String otp;

  SignupOTPValidatorParams({
    required this.email,
    required this.otp,
  });
}

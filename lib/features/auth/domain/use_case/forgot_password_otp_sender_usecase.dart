import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class ForgotPasswordOTPSenderUsecase extends UseCase<bool, String> {
  final IAuthRepository repository;

  ForgotPasswordOTPSenderUsecase({
    required this.repository,
  });

  @override
  Future<Either<AppErrorHandler, bool>> call(params) async {
    return await repository.forgotPasswordOTPSender(email: params);
  }
}

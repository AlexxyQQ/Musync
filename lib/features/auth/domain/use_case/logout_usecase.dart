import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCase extends UseCase<void, void> {
  final IAuthRepository repository;

  LogoutUseCase({
    required this.repository,
  });

  @override
  Future<Either<ErrorModel, void>> call(void params) async {
    return await repository.logout();
  }
}

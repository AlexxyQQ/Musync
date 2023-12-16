import 'package:dartz/dartz.dart';
import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase extends UseCase<void, void> {
  final IAuthRepository repository;

  LogoutUseCase({
    required this.repository,
  });

  @override
  Future<Either<AppErrorHandler, void>> call(void params) async {
    return await repository.logout();
  }
}

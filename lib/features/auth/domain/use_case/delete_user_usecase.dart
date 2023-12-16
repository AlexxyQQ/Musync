import 'package:dartz/dartz.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class DeleteUserUseCase extends UseCase<bool, String> {
  final IAuthRepository repository;

  DeleteUserUseCase({
    required this.repository,
  });

  @override
  Future<Either<AppErrorHandler, bool>> call(String params) async {
    return await repository.deleteUser(
      token: params,
    );
  }
}

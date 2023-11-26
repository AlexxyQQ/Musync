import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/usecase/usecase.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class DeleteUserUseCase extends UseCase<bool, String> {
  final IAuthRepository repository;

  DeleteUserUseCase({
    required this.repository,
  });

  @override
  Future<Either<ErrorModel, bool>> call(String params) async {
    return await repository.deleteUser(
      token: params,
    );
  }
}

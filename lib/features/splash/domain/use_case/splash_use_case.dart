import 'package:dartz/dartz.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/network/hive/hive_queries.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../repository/splash_repository.dart';

class InitialLoginUseCase extends UseCase<UserEntity, void> {
  final ISplashRepository splashRepository;
  final HiveQueries hiveQueries;

  InitialLoginUseCase({
    required this.splashRepository,
    required this.hiveQueries,
  });

  @override
  Future<Either<AppErrorHandler, UserEntity>> call(void params) async {
    try {
      String token = await hiveQueries.getValue(
        boxName: 'users',
        key: 'token',
        defaultValue: '',
      );
      final response = await splashRepository.initialLogin(
        token: token,
      );
      return response;
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/splash/domain/repository/splash_repository.dart';

class SplashUseCase {
  final ISplashRepository splashRepository;
  final HiveQueries hiveQueries;

  const SplashUseCase({
    required this.splashRepository,
    required this.hiveQueries,
  });

  Future<Either<ErrorModel, UserEntity>> initialLogin({
    bool biometric = false,
  }) async {
    try {
      String token = await hiveQueries.getValue(
        boxName: 'users',
        key: 'token',
        defaultValue: '',
      );
      String token2 = await hiveQueries.getValue(
        boxName: 'users',
        key: 'anotherToken',
        defaultValue: '',
      );
      final response = await splashRepository.initialLogin(
        token: biometric ? token2 : token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

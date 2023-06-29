import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/splash/data/data_source/splash_remote_data_source.dart';
import 'package:musync/features/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImpl extends ISplashRepository {
  final SplashRemoteDataSource splashRemoteDataSource;

  SplashRepositoryImpl({
    required this.splashRemoteDataSource,
  });

  @override
  Future<Either<ErrorModel, UserEntity>> initialLogin({
    required String token,
  }) async {
    try {
      final response = await splashRemoteDataSource.initialLogin(token: token);
      return response.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(UserEntity.fromMap(r));
        },
      );
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }
}

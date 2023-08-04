import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/utils/connectivity_check.dart';
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
    bool biometric = false,
  }) async {
    try {
      final isConnected = await ConnectivityCheck.connectivity();
      final isServerUp = await ConnectivityCheck.isServerup(recheck: true);

      if (isConnected && isServerUp) {
        final response = await splashRemoteDataSource.initialLogin(
          token: token,
          biometric: biometric,
        );
        return response.fold(
          (l) {
            return Left(l);
          },
          (r) {
            return Right(UserEntity.fromMap(r));
          },
        );
      } else {
        return Left(
          ErrorModel(
            message: 'No Internet Connection',
            status: false,
          ),
        );
      }
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

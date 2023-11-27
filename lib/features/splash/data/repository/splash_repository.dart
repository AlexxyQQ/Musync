import 'package:dartz/dartz.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/utils/connectivity_check.dart';
import '../../../auth/data/model/user_model.dart';
import '../../domain/repository/splash_repository.dart';
import '../data_source/splash_remote_data_source.dart';

class SplashRepositoryImpl extends ISplashRepository {
  final SplashRemoteDataSource splashRemoteDataSource;

  SplashRepositoryImpl({
    required this.splashRemoteDataSource,
  });

  @override
  Future<Either<AppErrorHandler, UserModel>> initialLogin({
    required String token,
    bool biometric = false,
  }) async {
    try {
      final isConnected = await ConnectivityCheck.connectivity();
      final isServerUp = await ConnectivityCheck.isServerup(recheck: true);

      if (isConnected && isServerUp) {
        final response = await splashRemoteDataSource.initialLogin(
          token: token,
        );
        return response.fold(
          (l) {
            return Left(l);
          },
          (r) {
            return Right(r);
          },
        );
      } else {
        return Left(
          AppErrorHandler(
            message: 'No Internet Connection',
            status: false,
          ),
        );
      }
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

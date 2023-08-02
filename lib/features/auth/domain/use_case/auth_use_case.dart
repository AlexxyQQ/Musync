import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/core/utils/device_info.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class AuthUseCase {
  final IAuthRepository authRepository;
  final HiveQueries hiveQueries;

  const AuthUseCase({
    required this.authRepository,
    required this.hiveQueries,
  });

  Future<Either<ErrorModel, UserEntity>> logout() async {
    try {
      await authRepository.logout();
      await hiveQueries.deleteValue(boxName: 'users', key: 'token');
      return Right(UserEntity.empty());
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<ErrorModel, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRepository.login(
        email: email,
        password: password,
      );

      return response.fold(
        (l) {
          return Left(l);
        },
        (r) {
          hiveQueries.setValue(
            boxName: 'users',
            key: 'token',
            value: r.token,
          );
          hiveQueries.setValue(
            boxName: 'settings',
            key: "goHome",
            value: true,
          );
          return response;
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<ErrorModel, UserEntity>> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await authRepository.signup(
        email: email,
        password: password,
        username: username,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<ErrorModel, UserEntity>> googleLogin() async {
    try {
      final response = await authRepository.googleLogin();
      return response.fold(
        (l) {
          return Left(l);
        },
        (r) {
          hiveQueries.setValue(
            boxName: 'users',
            key: 'token',
            value: r.token,
          );
          hiveQueries.setValue(
            boxName: 'settings',
            key: "goHome",
            value: true,
          );
          return response;
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<ErrorModel, bool>> socketConnection({
    required String loggedUserEmail,
  }) async {
    try {
      final device = await GetDeviceInfo.deviceInfoPlugin.androidInfo;
      final model = device.model;
      return await authRepository.socketConnection(
        loggedUserEmail: loggedUserEmail,
        loggedUserDevice: model,
      );
    } catch (e) {
      rethrow;
    }
  }
}

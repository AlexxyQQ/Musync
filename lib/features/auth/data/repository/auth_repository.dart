import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/auth/data/data_source/auth_data_source.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });

  @override
  Future<Either<ErrorModel, UserEntity>> googleLogin() async {
    try {
      final response = await authDataSource.google();
      return response.fold((l) {
        return Left(l);
      }, (r) {
        return Right(UserEntity.fromMap(r));
      });
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authDataSource.loginUser(
        email: email,
        password: password,
      );
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

  @override
  Future<Either<ErrorModel, void>> logout() async {
    try {
      return await authDataSource.logout();
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, UserEntity>> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await authDataSource.signupUser(
        email: email,
        password: password,
        username: username,
      );
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

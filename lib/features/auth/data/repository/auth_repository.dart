import 'package:musync/features/auth/data/data_source/auth_data_source.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });

  @override
  Future<UserEntity> googleLogin() async {
    try {
      final response = await authDataSource.google();
      return UserEntity.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> initialLogin({
    required String token,
  }) async {
    try {
      final response = await authDataSource.getUser(token: token);
      return UserEntity.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authDataSource.loginUser(
        email: email,
        password: password,
      );
      return UserEntity.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await authDataSource.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signup({
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
      return UserEntity.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }
}

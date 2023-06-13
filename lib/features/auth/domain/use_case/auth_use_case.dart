import 'package:get_it/get_it.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/repository/auth_repository.dart';

class AuthUseCase {
  final IAuthRepository authRepository;

  const AuthUseCase({required this.authRepository});

  Future<UserEntity> logout() async {
    try {
      await authRepository.logout();
      return UserEntity.empty();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserEntity> initialLogin({
    required String token,
  }) async {
    try {
      final response = await authRepository.initialLogin(
        token: token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRepository.login(
        email: email,
        password: password,
      );
      GetIt.instance<HiveQueries>().setValue(
        boxName: 'users',
        key: 'token',
        value: response.token,
      );
      GetIt.instance<HiveQueries>().setValue(
        boxName: 'settings',
        key: "goHome",
        value: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserEntity> signup({
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

  Future<UserEntity> googleLogin() async {
    try {
      final response = await authRepository.googleLogin();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:musync/features/auth/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });
  Future<UserEntity> signup({
    required String email,
    required String password,
    required String username,
  });
  Future<UserEntity> googleLogin();
  Future<void> logout();
  Future<UserEntity> initialLogin({
    required String token,
  });
}

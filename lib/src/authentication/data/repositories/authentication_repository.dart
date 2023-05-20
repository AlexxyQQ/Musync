import 'package:musync/src/common/data/models/error_model.dart';

abstract class AuthenticationRepository {
  Future<ErrorModel> signUpGoogle();
  Future<ErrorModel> signUpManual({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
    String? profilePic,
    required String type,
  });
  Future<ErrorModel> signInManual({
    required String email,
    required String password,
  });
  Future<ErrorModel> getUserData();
  void signOut();
}

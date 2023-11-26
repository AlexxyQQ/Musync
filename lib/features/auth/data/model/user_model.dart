import 'dart:convert';

import 'package:musync/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String username,
    required String email,
    required String password,
    required String profilePic,
    required bool verified,
    required String type,
    required String token,
  }) : super(
          id: id,
          username: username,
          email: email,
          password: password,
          profilePic: profilePic,
          verified: verified,
          type: type,
          token: token,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profilePic: map['profilePic'] as String,
      verified: map['verified'] as bool,
      type: map['type'] as String,
      token: map['token'] as String,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, password: $password, profilePic: $profilePic, verified: $verified, type: $type, token: $token)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.password == password &&
        other.profilePic == profilePic &&
        other.verified == verified &&
        other.type == type &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        password.hashCode ^
        profilePic.hashCode ^
        verified.hashCode ^
        type.hashCode ^
        token.hashCode;
  }
}

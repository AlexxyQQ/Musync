import 'dart:convert';

import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String? id,
    required String? username,
    required String? email,
    required String? password,
    required String? profilePic,
    required bool? verified,
    required String? type,
    required String? token,
    required String? otp,
    required String? createdAt,
  }) : super(
          id: id,
          username: username,
          email: email,
          password: password,
          profilePic: profilePic,
          verified: verified,
          type: type,
          token: token,
          otp: otp,
          createdAt: createdAt,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
      verified: map['verified'] != null ? map['verified'] as bool : null,
      type: map['type'] != null ? map['type'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      otp: map['otp'] != null ? map['otp'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return 'UserModel Details:\n'
        '  - ID: $id\n'
        '  - Username: $username\n'
        '  - Email: $email\n'
        '  - Password: [PROTECTED]\n' // Assuming you want to hide the password in logs
        '  - Profile Picture: $profilePic\n'
        '  - Verified: $verified\n'
        '  - Type: $type\n'
        '  - Token: [PROTECTED]\n' // Assuming you want to hide the token as well
        '  - OTP: $otp';
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
        other.token == token &&
        other.otp == otp;
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
        token.hashCode ^
        otp.hashCode;
  }
}

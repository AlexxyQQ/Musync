// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String profilePic;
  final String type;
  final String uid;
  final String token;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.profilePic,
    required this.type,
    required this.uid,
    required this.token,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
    String? profilePic,
    String? type,
    String? uid,
    String? token,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      profilePic: profilePic ?? this.profilePic,
      type: type ?? this.type,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'profilePic': profilePic,
      'type': type,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      profilePic: map['profilePic'] as String,
      type: map['type'] as String,
      uid: map['uid'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, password: $password, confirmPassword: $confirmPassword, profilePic: $profilePic, type: $type, uid: $uid, token: $token)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.profilePic == profilePic &&
        other.type == type &&
        other.uid == uid &&
        other.token == token;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        profilePic.hashCode ^
        type.hashCode ^
        uid.hashCode ^
        token.hashCode;
  }
}

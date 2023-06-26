import 'dart:convert';

class UserModel {
  String id;
  String username;
  String email;
  String password;
  String profilePic;
  bool verified;
  String type;
  String token;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.verified,
    required this.type,
    required this.token,
  });

  UserModel.empty()
      : id = '',
        username = '',
        email = '',
        password = '',
        profilePic = '',
        verified = false,
        type = '',
        token = '';

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? profilePic,
    bool? verified,
    String? type,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePic: profilePic ?? this.profilePic,
      verified: verified ?? this.verified,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profilePic': profilePic,
      'verified': verified,
      'type': type,
      'token': token,
    };
  }

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

  String toJson() => json.encode(toMap());

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

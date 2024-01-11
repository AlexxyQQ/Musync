import 'dart:convert';

class UserEntity {
  String? id;
  String? username;
  String? email;
  String? password;
  String? profilePic;
  bool? verified;
  String? type;
  String? token;
  String? otp;
  String? createdAt;
  UserEntity({
    this.id,
    this.username,
    this.email,
    this.password,
    this.profilePic,
    this.verified,
    this.type,
    this.token,
    this.otp,
    this.createdAt,
  });

  UserEntity copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? profilePic,
    bool? verified,
    String? type,
    String? token,
    String? otp,
    String? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePic: profilePic ?? this.profilePic,
      verified: verified ?? this.verified,
      type: type ?? this.type,
      token: token ?? this.token,
      otp: otp ?? this.otp,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profile_pic': profilePic,
      'verified': verified,
      'type': type,
      'token': token,
      'otp': otp,
      'createdAt': createdAt,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['_id'] != null ? map['_id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      profilePic:
          map['profile_pic'] != null ? map['profile_pic'] as String : null,
      verified: map['verified'] != null ? map['verified'] as bool : null,
      type: map['type'] != null ? map['type'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      otp: map['otp'] != null ? map['otp'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEntity Details:\n'
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
  bool operator ==(covariant UserEntity other) {
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

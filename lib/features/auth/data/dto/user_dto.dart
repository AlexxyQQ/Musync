import 'dart:convert';

import 'package:musync/features/auth/data/model/user_model.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';

class UserDTO {
  final UserEntity? user;
  final String? token;

  UserDTO({
    this.user,
    this.token,
  });

  UserDTO copyWith({
    UserEntity? user,
    String? token,
  }) =>
      UserDTO(
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory UserDTO.fromJson(String str) => UserDTO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDTO.fromMap(Map<String, dynamic> json) => UserDTO(
        user: json["user"] == null ? null : UserEntity.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "user": user?.toMap(),
        "token": token,
      };

  static UserModel fromDTOtoEntity(UserDTO data) => UserModel(
        id: data.user?.id,
        username: data.user?.username,
        email: data.user?.email,
        password: data.user?.password,
        profilePic: data.user?.profilePic,
        verified: data.user?.verified,
        type: data.user?.type,
        token: data.token,
        otp: data.user?.otp,
        createdAt: data.user?.createdAt,
      );
}

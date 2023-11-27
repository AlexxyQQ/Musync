import 'dart:convert';

import '../../../../core/failure/error_handler.dart';
import '../../domain/entity/user_entity.dart';

class AuthenticationState {
  final UserEntity? loggedUser;
  final bool isLoading;
  final bool isSuccess;
  final AppErrorHandler? eror;
  final String? token;
  final bool isFirstTime;
  final bool goHome;
  AuthenticationState({
    this.loggedUser,
    required this.isLoading,
    required this.isSuccess,
    this.eror,
    this.token,
    required this.isFirstTime,
    required this.goHome,
  });

  factory AuthenticationState.initial() => AuthenticationState(
        loggedUser: null,
        isLoading: false,
        eror: null,
        token: null,
        isSuccess: false,
        isFirstTime: true,
        goHome: false,
      );

  AuthenticationState copyWith({
    UserEntity? loggedUser,
    bool? isLoading,
    bool? isSuccess,
    AppErrorHandler? eror,
    String? token,
    bool? isFirstTime,
    bool? goHome,
  }) {
    return AuthenticationState(
      loggedUser: loggedUser ?? this.loggedUser,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      eror: eror ?? this.eror,
      token: token ?? this.token,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      goHome: goHome ?? this.goHome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loggedUser': loggedUser?.toMap(),
      'isLoading': isLoading,
      'isSuccess': isSuccess,
      'eror': eror?.toMap(),
      'token': token,
      'isFirstTime': isFirstTime,
      'goHome': goHome,
    };
  }

  factory AuthenticationState.fromMap(Map<String, dynamic> map) {
    return AuthenticationState(
      loggedUser: map['loggedUser'] != null
          ? UserEntity.fromMap(map['loggedUser'] as Map<String, dynamic>)
          : null,
      isLoading: map['isLoading'] as bool,
      isSuccess: map['isSuccess'] as bool,
      eror: map['eror'] != null
          ? AppErrorHandler.fromMap(map['eror'] as Map<String, dynamic>)
          : null,
      token: map['token'] != null ? map['token'] as String : null,
      isFirstTime: map['isFirstTime'] as bool,
      goHome: map['goHome'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationState.fromJson(String source) =>
      AuthenticationState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthState(loggedUser: $loggedUser, isLoading: $isLoading, isSuccess: $isSuccess, eror: $eror, token: $token, isFirstTime: $isFirstTime, goHome: $goHome)';
  }

  @override
  bool operator ==(covariant AuthenticationState other) {
    if (identical(this, other)) return true;

    return other.loggedUser == loggedUser &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.eror == eror &&
        other.token == token &&
        other.isFirstTime == isFirstTime &&
        other.goHome == goHome;
  }

  @override
  int get hashCode {
    return loggedUser.hashCode ^
        isLoading.hashCode ^
        isSuccess.hashCode ^
        eror.hashCode ^
        token.hashCode ^
        isFirstTime.hashCode ^
        goHome.hashCode;
  }
}

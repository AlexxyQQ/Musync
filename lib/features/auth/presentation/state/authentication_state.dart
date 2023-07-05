import 'dart:convert';

import 'package:musync/features/auth/domain/entity/user_entity.dart';

class AuthState {
  final UserEntity? loggedUser;
  final bool isLoading;
  final String? authError;
  final bool isError;
  final bool isLogin;
  final bool isSignUp;
  final bool isLogout;
  final String? token;
  final bool isFirstTime;
  final bool goHome;

  AuthState({
    required this.loggedUser,
    required this.isLoading,
    this.authError,
    required this.isError,
    required this.isLogin,
    required this.isSignUp,
    required this.isLogout,
    this.token,
    required this.isFirstTime,
    required this.goHome,
  });

  factory AuthState.initial() {
    return AuthState(
      loggedUser: UserEntity(
        id: "0",
        username: 'Guest',
        email: 'Guest',
        password: 'Guest',
        token: '',
        profilePic: 'assets/default_profile.jpeg',
        verified: false,
        type: 'guest',
      ),
      isLoading: false,
      authError: null,
      isLogin: false,
      isSignUp: false,
      isLogout: false,
      token: null,
      isError: false,
      isFirstTime: true,
      goHome: false,
    );
  }

  AuthState copyWith({
    UserEntity? loggedUser,
    bool? isLoading,
    String? authError,
    bool? isError,
    bool? isLogin,
    bool? isSignUp,
    bool? isLogout,
    String? token,
    bool? isFirstTime,
    bool? goHome,
  }) {
    return AuthState(
      loggedUser: loggedUser ?? this.loggedUser,
      isLoading: isLoading ?? this.isLoading,
      authError: authError ?? this.authError,
      isError: isError ?? this.isError,
      isLogin: isLogin ?? this.isLogin,
      isSignUp: isSignUp ?? this.isSignUp,
      isLogout: isLogout ?? this.isLogout,
      token: token ?? this.token,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      goHome: goHome ?? this.goHome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loggedUser': loggedUser?.toMap(),
      'isLoading': isLoading,
      'authError': authError,
      'isError': isError,
      'isLogin': isLogin,
      'isSignUp': isSignUp,
      'isLogout': isLogout,
      'token': token,
      'isFirstTime': isFirstTime,
      'goHome': goHome,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      loggedUser: map['loggedUser'] != null
          ? UserEntity.fromMap(map['loggedUser'] as Map<String, dynamic>)
          : null,
      isLoading: map['isLoading'] as bool,
      authError: map['authError'] != null ? map['authError'] as String : null,
      isError: map['isError'] as bool,
      isLogin: map['isLogin'] as bool,
      isSignUp: map['isSignUp'] as bool,
      isLogout: map['isLogout'] as bool,
      token: map['token'] != null ? map['token'] as String : null,
      isFirstTime: map['isFirstTime'] as bool,
      goHome: map['goHome'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthState(loggedUser: $loggedUser, isLoading: $isLoading, authError: $authError, isError: $isError, isLogin: $isLogin, isSignUp: $isSignUp, isLogout: $isLogout, token: $token, isFirstTime: $isFirstTime, goHome: $goHome)';
  }

  @override
  bool operator ==(covariant AuthState other) {
    if (identical(this, other)) return true;

    return other.loggedUser == loggedUser &&
        other.isLoading == isLoading &&
        other.authError == authError &&
        other.isError == isError &&
        other.isLogin == isLogin &&
        other.isSignUp == isSignUp &&
        other.isLogout == isLogout &&
        other.token == token &&
        other.isFirstTime == isFirstTime &&
        other.goHome == goHome;
  }

  @override
  int get hashCode {
    return loggedUser.hashCode ^
        isLoading.hashCode ^
        authError.hashCode ^
        isError.hashCode ^
        isLogin.hashCode ^
        isSignUp.hashCode ^
        isLogout.hashCode ^
        token.hashCode ^
        isFirstTime.hashCode ^
        goHome.hashCode;
  }
}

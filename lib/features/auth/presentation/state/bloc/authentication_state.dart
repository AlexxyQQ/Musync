part of 'authentication_bloc.dart';

class AuthenticationState {
  final UserEntity? user;
  final String? token;
  final String? userId;
  final String? message;
  BlocStatus? status;

  AuthenticationState({
    this.user,
    this.token,
    this.userId,
    this.status,
    this.message,
  });

  AuthenticationState start() {
    return AuthenticationState(
      user: null,
      token: null,
      userId: null,
      message: 'Started',
      status: BlocStatus.created,
    );
  }

  // Copywith
  AuthenticationState copyWith({
    UserEntity? user,
    String? token,
    String? userId,
    BlocStatus? status,
    String? message,
  }) {
    return AuthenticationState(
      user: user ?? this.user,
      token: token ?? this.token,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

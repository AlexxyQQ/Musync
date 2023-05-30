part of 'authentication_bloc.dart';

// abstract class AuthenticationState {}

// class AuthenticationInitial extends AuthenticationState {}

// class AuthenticationLoading extends AuthenticationState {}

// class AuthenticationSuccess extends AuthenticationState {
//   final UserModel user;

//   AuthenticationSuccess({
//     required this.user,
//   });
// }

// class AuthenticationError extends AuthenticationState {
//   final String message;

//   AuthenticationError({
//     required this.message,
//   });
// }

// class AuthenticationLogout extends AuthenticationState {}

class AuthenticationState {
  final UserModel? user;
  final String? token;
  final String? userId;
  final String? message;
  Status? status;

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
      status: Status.created,
    );
  }

  // Copywith
  AuthenticationState copyWith({
    UserModel? user,
    String? token,
    String? userId,
    Status? status,
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

part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final UserModel user;

  AuthenticationSuccess({
    required this.user,
  });
}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError({
    required this.message,
  });
}

class AuthenticationLogout extends AuthenticationState {}


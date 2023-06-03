part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

class SignupEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;

  SignupEvent({
    required this.email,
    required this.password,
    required this.username,
  });
}

class GoogleEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}

class InitialLogin extends AuthenticationEvent {
  final String token;

  InitialLogin({
    required this.token,
  });
}

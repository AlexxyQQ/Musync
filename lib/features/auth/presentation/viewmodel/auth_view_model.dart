import 'package:flutter/material.dart';
import 'package:musync/config/constants/enums.dart';
import 'package:musync/features/auth/presentation/state/bloc/authentication_bloc.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticationBloc authenticationBloc;

  AuthViewModel({required this.authenticationBloc}) {
    _init();
  }

  void _init() {
    authenticationBloc.stream.listen((state) {
      if (state.status == BlocStatus.success) {
        print('Success');
      } else if (state.status == BlocStatus.error) {
        print('Error');
      } else if (state.status == BlocStatus.loading) {
        print('Loading');
      }
    });
  }

  void initialLogin(String token) {
    authenticationBloc.add(InitialLogin(token: token));
  }

  void signupUser({
    required String email,
    required String password,
    required String username,
  }) {
    authenticationBloc.add(
      SignupEvent(
        email: email,
        password: password,
        username: username,
      ),
    );
  }

  void loginUser({required String email, required String password}) {
    authenticationBloc.add(
      LoginEvent(
        email: email,
        password: password,
      ),
    );
  }

  void googleLoginUser() {
    authenticationBloc.add(GoogleEvent());
  }

  void logoutUser() {
    authenticationBloc.add(LogoutEvent());
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/constants/enums.dart';
import 'package:musync/core/models/user_model.dart';
import 'package:musync/core/repositories/user_repositories.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState().start()) {
    on<InitialLogin>((event, emit) async {
      try {
        emit(
          state.copyWith(
            status: Status.loading,
          ),
        );
        final UserModel user = await UserRepositories().getUser(
          token: event.token,
        );

        emit(
          state.copyWith(
            user: user,
            token: user.token,
            userId: user.id,
            message: 'Login Success',
            status: Status.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: Status.error,
          ),
        );
      }
    });
    on<SignupEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            message: 'Started',
            status: Status.loading,
          ),
        );
        final UserModel user = await UserRepositories().signup(
          email: event.email,
          password: event.password,
          username: event.username,
        );

        emit(
          state.copyWith(
            user: user,
            message: 'Signup Success',
            status: Status.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: Status.error,
          ),
        );
      }
    });
    on<LoginEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            message: 'Started',
            status: Status.loading,
          ),
        );
        final UserModel user = await UserRepositories().login(
          email: event.email,
          password: event.password,
        );

        emit(
          state.copyWith(
            user: user,
            token: user.token,
            userId: user.id,
            message: 'Login Success',
            status: Status.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: Status.error,
          ),
        );
      }
    });
    on<LogoutEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            message: 'Started',
            status: Status.loading,
          ),
        );
        await UserRepositories().logout();

        emit(
          state.copyWith(
            user: null,
            token: null,
            userId: null,
            message: 'Logout Success',
            status: Status.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: Status.error,
          ),
        );
      }
    });

    on<GoogleEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            message: 'Started',
            status: Status.loading,
          ),
        );
        final UserModel user = await UserRepositories().google();
        emit(
          state.copyWith(
            user: user,
            message: 'Signup Success',
            status: Status.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: Status.error,
          ),
        );
      }
    });
  }
}

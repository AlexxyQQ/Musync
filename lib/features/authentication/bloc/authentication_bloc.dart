import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/core/common/data/repositories/local_storage_repository.dart';
import 'package:musync/features/authentication/data/models/user_model.dart';
import 'package:musync/features/authentication/repositories/user_repositories.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is InitialLogin) {
        emit(AuthenticationLoading());
        try {
          final UserModel user = await UserRepositories().getUser(
            token: event.token,
          );
          emit(
            AuthenticationSuccess(
              user: user,
            ),
          );
        } catch (e) {
          emit(
            AuthenticationError(
              message: e.toString(),
            ),
          );
        }
      } else if (event is LoginEvent) {
        emit(AuthenticationLoading());
        try {
          final UserModel user = await UserRepositories().login(
            email: event.email,
            password: event.password,
          );
          // Save token to local storage
          LocalStorageRepository().setValue(
            boxName: 'users',
            key: 'token',
            value: user.token,
          );
          // Set goHome to true
          LocalStorageRepository().setValue(
            boxName: 'settings',
            key: "goHome",
            value: true,
          );
          emit(
            AuthenticationSuccess(
              user: user,
            ),
          );
        } catch (e) {
          emit(
            AuthenticationError(
              message: e.toString(),
            ),
          );
        }
      } else if (event is SignupEvent) {
        emit(AuthenticationLoading());
        try {
          final UserModel user = await UserRepositories().signup(
            email: event.email,
            password: event.password,
            username: event.username,
          );

          emit(
            AuthenticationSuccess(
              user: user,
            ),
          );
        } catch (e) {
          emit(
            AuthenticationError(
              message: e.toString(),
            ),
          );
        }
      } else if (event is LogoutEvent) {
        emit(AuthenticationLoading());
        try {
          UserRepositories().logout();
        } catch (e) {
          emit(
            AuthenticationError(
              message: e.toString(),
            ),
          );
        }
      }
    });
  }
}

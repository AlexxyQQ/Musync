import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/enums.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/use_case/auth_use_case.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthUseCase authUseCase;

  AuthenticationBloc(this.authUseCase) : super(AuthenticationState().start()) {
    on<InitialLogin>((event, emit) async {
      try {
        emit(
          state.copyWith(
            status: BlocStatus.loading,
          ),
        );

        final UserEntity user = await authUseCase.initialLogin(
          token: event.token,
        );
        emit(
          state.copyWith(
            user: user,
            token: user.token,
            userId: user.id,
            message: 'Login Success',
            status: BlocStatus.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: BlocStatus.error,
          ),
        );
      }
    });
    on<SignupEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            message: 'Started',
            status: BlocStatus.loading,
          ),
        );
        // final UserEntity user = await userRepo.signupUser(
        //   email: event.email,
        //   password: event.password,
        //   username: event.username,
        // );

        final UserEntity user = await authUseCase.signup(
          email: event.email,
          password: event.password,
          username: event.username,
        );

        emit(
          state.copyWith(
            user: user,
            message: 'Signup Success',
            status: BlocStatus.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: BlocStatus.error,
          ),
        );
      }
    });
    on<LoginEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            message: 'Started',
            status: BlocStatus.loading,
          ),
        );
        // final UserEntity user = await userRepo.loginUser(
        //   email: event.email,
        //   password: event.password,
        // );
        final UserEntity user = await authUseCase.login(
          email: event.email,
          password: event.password,
        );

        emit(
          state.copyWith(
            user: user,
            token: user.token,
            userId: user.id,
            message: 'Login Success',
            status: BlocStatus.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: BlocStatus.error,
          ),
        );
      }
    });
    on<LogoutEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            message: 'Started',
            status: BlocStatus.loading,
          ),
        );
        // await userRepo.logout();

        await authUseCase.logout();

        emit(
          state.copyWith(
            user: null,
            token: null,
            userId: null,
            message: 'Logout Success',
            status: BlocStatus.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: BlocStatus.error,
          ),
        );
      }
    });

    on<GoogleEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            message: 'Started',
            status: BlocStatus.loading,
          ),
        );
        // final UserEntity user = await userRepo.google();

        final UserEntity user = await authUseCase.googleLogin();

        emit(
          state.copyWith(
            user: user,
            message: 'Signup Success',
            status: BlocStatus.success,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            message: e.toString(),
            status: BlocStatus.error,
          ),
        );
      }
    });
  }
}

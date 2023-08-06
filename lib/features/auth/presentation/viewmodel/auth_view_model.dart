import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/auth/domain/use_case/auth_use_case.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/splash/domain/use_case/splash_use_case.dart';

class AuthViewModel extends Cubit<AuthState> {
  final AuthUseCase authUseCase;
  final SplashUseCase splashUseCase;
  AuthViewModel({
    required this.authUseCase,
    required this.splashUseCase,
  }) : super(AuthState.initial());

  Future<void> checkDeviceSupportForBiometrics() async {
    final data = await authUseCase.checkDeviceSupportForBiometrics();

    data.fold(
      (l) => emit(
        state.copyWith(
          supportBioMetricState: false,
        ),
      ),
      (r) async {
        final localAuth = GetIt.instance<LocalAuthentication>();
        final List<BiometricType> avilableBiometrices =
            r ? await localAuth.getAvailableBiometrics() : [];
        emit(
          state.copyWith(
            supportBioMetricState: r,
            localAuth: localAuth,
            avilableBiometrices: avilableBiometrices,
          ),
        );
      },
    );
  }

  Future<void> allowLoginWithBiometric({required bool value}) async {
    emit(
      state.copyWith(
        allowLoginWithBiometric: value,
      ),
    );
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      bool isAuthorized = await state.localAuth!.authenticate(
        localizedReason: 'Musync Login',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      if (state.allowLoginWithBiometric && isAuthorized) {
        await initialLogin(biometric: true);
      }
    } on PlatformException catch (e) {
      emit(
        state.copyWith(
          isError: true,
          authError: e.message,
        ),
      );
    }
  }

  Future<void> initialLogin({
    bool biometric = false,
  }) async {
    emit(state.copyWith(isLoading: true, authError: null));
    final data = await splashUseCase.initialLogin(biometric: biometric);
    final goHomeHive = await GetIt.instance<HiveQueries>()
        .getValue(boxName: 'settings', key: 'goHome', defaultValue: false);
    final isFirstTime = await GetIt.instance<HiveQueries>()
        .getValue(boxName: 'settings', key: 'isFirstTime', defaultValue: true);

    data.fold(
      (l) => emit(
        state.copyWith(
          isFirstTime: isFirstTime,
          goHome: goHomeHive,
          isError: true,
          isLoading: false,
          authError: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          isFirstTime: isFirstTime,
          goHome: goHomeHive,
          isError: false,
          authError: null,
          isLoading: false,
          loggedUser: r,
          isLogin: true,
        ),
      ),
    );
  }

  Future<void> signupUser({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(state.copyWith(isLoading: true, authError: null));
    final data = await authUseCase.signup(
      email: email,
      password: password,
      username: username,
    );
    data.fold(
      (l) {
        emit(
          state.copyWith(
            isError: true,
            isLoading: false,
            authError: l.message,
          ),
        );
      },
      (r) {
        state.copyWith(authError: null);
        emit(
          state.copyWith(
            isError: false,
            authError: null,
            isLoading: false,
            isSignUp: true,
            isLogin: false,
          ),
        );
      },
    );
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, authError: null, isError: null));

    final data = await authUseCase.login(
      email: email,
      password: password,
    );

    if (data.isLeft()) {
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          authError: data.leftMap((l) => l.message).fold((l) => l, (r) => null),
        ),
      );
    } else {
      emit(
        state.copyWith(
          isError: false,
          authError: null,
          isLoading: false,
          loggedUser: data.fold((l) => null, (r) => r),
          isLogin: true,
          isSignUp: false,
        ),
      );
    }
  }

  Future<void> googleLoginUser() async {
    emit(state.copyWith(isLoading: true, authError: null));

    final data = await authUseCase.googleLogin();
    data.fold(
      (l) => emit(
        state.copyWith(
          isError: true,
          isLoading: false,
          authError: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          isError: false,
          authError: null,
          isLoading: false,
          loggedUser: r,
          isLogin: true,
        ),
      ),
    );
  }

  Future<void> logoutUser() async {
    emit(state.copyWith(isLoading: true, authError: null, token: null));

    final data = await authUseCase.logout();
    data.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          authError: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          isError: false,
          authError: null,
          isLoading: false,
          isLogin: false,
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
        ),
      ),
    );
  }

  Future<void> uploadProfilePic({
    required String path,
  }) async {
    emit(state.copyWith(isLoading: true, authError: null));

    final data = await authUseCase.uploadProfilePic(
      profilePicPath: path,
    );

    data.fold(
      (l) => emit(
        state.copyWith(
          isError: true,
          isLoading: false,
          authError: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          isError: false,
          authError: null,
          isLoading: false,
          loggedUser: r,
          isLogin: true,
        ),
      ),
    );
  }

  Future<void> deleteUser() async {
    emit(state.copyWith(isLoading: true, authError: null));

    final data = await authUseCase.deleteUser();

    data.fold(
      (l) => emit(
        state.copyWith(
          isError: true,
          isLoading: false,
          authError: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          isError: false,
          authError: null,
          isLoading: false,
          isLogin: false,
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
        ),
      ),
    );
  }
}

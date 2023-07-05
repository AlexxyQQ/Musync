import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/splash/domain/use_case/splash_use_case.dart';

class SplashViewModel extends Cubit<AuthState> {
  final SplashUseCase splashUseCase;
  SplashViewModel({required this.splashUseCase}) : super(AuthState.initial());

  Future<void> initialLogin() async {
    emit(state.copyWith(isLoading: true, authError: null));

    final data = await splashUseCase.initialLogin();
    data.fold(
      (l) => emit(
        state.copyWith(
          isFirstTime: false,
          goHome: false,
          isError: true,
          isLoading: false,
          authError: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          isFirstTime: false,
          goHome: true,
          isError: false,
          authError: null,
          isLoading: false,
          loggedUser: r,
          isLogin: true,
        ),
      ),
    );
  }
}

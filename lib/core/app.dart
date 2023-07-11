import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/config/themes/app_theme.dart';
import 'package:musync/features/auth/domain/use_case/auth_use_case.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/features/home/domain/use_case/music_query_use_case.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/nowplaying2/domain/use_case/now_playing_use_case.dart';
import 'package:musync/features/nowplaying2/presentation/view_model/now_playing_view_model.dart';
import 'package:musync/features/splash/domain/use_case/splash_use_case.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthViewModel(
            authUseCase: GetIt.instance<AuthUseCase>(),
            splashUseCase: GetIt.instance<SplashUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              MusicQueryViewModel(GetIt.instance<MusicQueryUseCase>()),
        ),
        BlocProvider(
          create: (context) =>
              NowPlayingViewModel(GetIt.instance<NowPlayingUseCase>()),
        ),
      ],
      child: BlocBuilder<AuthViewModel, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            title: "Musync",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appLightTheme(),
            darkTheme: AppTheme.appDarkTheme(),
            themeMode: ThemeMode.system,
            routes: state.loggedUser == null
                ? AppRoutes.loggedoutRoute
                : AppRoutes.loggedinRoute,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/features/auth/domain/use_case/auth_use_case.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/features/home/domain/use_case/music_query_use_case.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/splash/domain/use_case/splash_use_case.dart';
import 'package:musync/features/splash/presentation/view/splashscreen.dart';
import 'package:musync/features/splash/presentation/viewmodel/splash_view_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthViewModel(
            authUseCase: GetIt.instance<AuthUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => SplashViewModel(
            splashUseCase: GetIt.instance<SplashUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              MusicQueryViewModel(GetIt.instance<MusicQueryUseCase>()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MusyncSplash(),
      ),
    );
  }
}

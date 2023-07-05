import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/common/loading_screen.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/config/themes/app_theme.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/splash/presentation/viewmodel/splash_view_model.dart';

class MusyncSplash extends StatefulWidget {
  const MusyncSplash({super.key});

  @override
  State<MusyncSplash> createState() => _MusyncSplashState();
}

class _MusyncSplashState extends State<MusyncSplash> {
  @override
  void initState() {
    BlocProvider.of<SplashViewModel>(context).initialLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashViewModel, AuthState>(
        builder: (blocContext, state) {
          if (state.isLoading) {
            return const LoadingScreen();
          } else {
            if (state.isError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                kShowSnackBar(
                  state.authError!,
                  context: blocContext,
                );
              });
              return const Scaffold(
                body: Center(
                  child: Text('404'),
                ),
              );
            }
            if (state.isFirstTime) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                kShowSnackBar(
                  "Welcome to Musync!",
                  context: blocContext,
                );
              });
            }

            if (state.goHome && state.loggedUser != null && !state.isError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                kShowSnackBar(
                  "Welcome back ${state.loggedUser!.username}!",
                  context: blocContext,
                );
              });
              return const Scaffold(
                body: Center(
                  child: Text('Home Page'),
                ),
              );
            }

            return const Scaffold(
              body: Center(
                child: Text(''),
              ),
            );
            // ! This is the original code
            // return SplashMaterial(
            //   state: state,
            //   blocContext: blocContext,
            // );
          }
        },
      ),
    );
  }
}

class SplashMaterial extends StatelessWidget {
  final AuthState state;
  final BuildContext blocContext;
  const SplashMaterial({
    super.key,
    required this.state,
    required this.blocContext,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Musync",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appLightTheme(),
      darkTheme: AppTheme.appDarkTheme(),
      themeMode: ThemeMode.system,
      routes: state.loggedUser == null
          ? AppRoutes.loggedoutRoute
          : AppRoutes.loggedinRoute,
      onGenerateInitialRoutes: (initialRoute) =>
          AppRoutes.generateInitialRoutes(
        initialRoute: '/',
        context: blocContext,
        isFirstTime: state.isFirstTime,
        goHome: state.goHome,
      ),
    );
  }
}

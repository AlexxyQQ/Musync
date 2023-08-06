import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/common/loading_screen.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';

class MusyncSplash extends StatefulWidget {
  const MusyncSplash({super.key});

  @override
  State<MusyncSplash> createState() => _MusyncSplashState();
}

class _MusyncSplashState extends State<MusyncSplash> {
  @override
  void initState() {
    super.initState();
    sothing();
  }

  Future<void> sothing() async {
    await BlocProvider.of<AuthViewModel>(context).initialLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthViewModel, AuthState>(
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
            }
            if (state.isFirstTime) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // kShowSnackBar(
                //   "Welcome to Musync!",
                //   context: blocContext,
                // );
                Navigator.popAndPushNamed(context, AppRoutes.onBoardingRoute);
              });
            }

            if (state.goHome && state.loggedUser != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // kShowSnackBar(
                //   "Welcome back ${state.loggedUser!.username}!",
                //   context: blocContext,
                // );
                Navigator.popAndPushNamed(context, AppRoutes.homeRoute);
              });
            }
            if (!state.goHome && !state.isFirstTime) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.popAndPushNamed(context, AppRoutes.getStartedRoute);
              });
            }

            return const LoadingScreen();
          }
        },
      ),
    );
  }
}

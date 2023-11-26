// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/common/loading_screen.dart';
import 'package:musync/core/utils/device_info.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/features/socket/presentation/view_model/socket_view_model.dart';

class MusyncSplash extends StatefulWidget {
  const MusyncSplash({super.key});

  @override
  State<MusyncSplash> createState() => _MusyncSplashState();
}

class _MusyncSplashState extends State<MusyncSplash> {
  @override
  void initState() {
    super.initState();
    initialDataFetch();
  }

  late String model = 'Mobile';
  Future<void> initialDataFetch() async {
    await BlocProvider.of<AuthViewModel>(context).initialLogin();
    final device = await GetDeviceInfo.deviceInfoPlugin.androidInfo;
    model = device.model;
    if (BlocProvider.of<AuthViewModel>(context).state.loggedUser!.email !=
        'Guest') {
      BlocProvider.of<SocketCubit>(context).disconnect();
      BlocProvider.of<SocketCubit>(context).initSocket(
        loggedUser: BlocProvider.of<AuthViewModel>(context).state.loggedUser,
        model: model,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthViewModel, AuthState>(
        listener: (listenerContext, state) {
          log("SplashScreen ${state.toString()}");
          if (state.isError && !state.errorMsg!.contains('token')) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              kShowSnackBar(
                state.errorMsg!,
                color: Colors.red,
                context: listenerContext,
              );
            });
          }
          if (state.isFirstTime) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              kShowSnackBar(
                "Welcome to Musync!",
                color: KColors.accentColor,
                context: listenerContext,
              );
              Navigator.popAndPushNamed(
                  listenerContext, AppRoutes.onBoardingRoute,);
            });
          }

          if (state.goHome &&
              state.loggedUser != null &&
              state.loggedUser!.username != "Guest" &&
              !state.isFirstTime) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              kShowSnackBar(
                "Welcome back ${state.loggedUser!.username}!",
                context: listenerContext,
                color: Colors.green,
              );
              Navigator.popAndPushNamed(listenerContext, AppRoutes.homeRoute);
            });
          }
          if (!state.goHome && !state.isFirstTime) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.popAndPushNamed(
                listenerContext,
                AppRoutes.getStartedRoute,
              );
            });
          }
        },
        builder: (builderContext, state) {
          if (state.isLoading) {
            return const LoadingScreen();
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}

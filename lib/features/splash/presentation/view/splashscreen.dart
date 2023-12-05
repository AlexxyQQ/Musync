import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/injection/app_injection_container.dart';

import '../../../auth/presentation/cubit/authentication_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final nav = Navigator.of(context);
    final authCubit = BlocProvider.of<AuthenticationCubit>(context);
    await authCubit.initialLogin(context: context);

    final settings = await get<SettingsHiveService>().getSettings();

    if (settings.firstTime) {
      nav.pushNamed(AppRoutes.onBoardingRoute);
    } else if ((authCubit.state.loggedUser != null &&
            authCubit.state.loggedUser!.username != null) ||
        settings.goHome) {
      nav.pushNamed(AppRoutes.homeRoute);
    } else {
      nav.pushNamed(AppRoutes.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppAccentColor.yellow,
          strokeWidth: 6,
          strokeCap: StrokeCap.round,
          semanticsValue: 'Loading...',
          semanticsLabel: 'Loading...',
        ),
      ),
    );
  }
}

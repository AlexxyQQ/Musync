import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    if (authCubit.state.loggedUser != null &&
        authCubit.state.loggedUser!.username != null) {
      nav.pushNamed('/home');
    } else {
      nav.pushNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

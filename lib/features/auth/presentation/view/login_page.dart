import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/route/routes.dart';
import 'package:musync/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:musync/features/auth/presentation/widgets/auth_page_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "aayushpandey616@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "VerySecretPassword@100");

  bool isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthComponent(
      redirectRoute: AppRoutes.signupRoute,
      redirectLabel: 'Sign Up',
      canBack: true,
      fromKey: formKey,
      backRoute: AppRoutes.getStartedRoute,
      darkMode: MediaQuery.of(context).platformBrightness == Brightness.dark,
      controllersMap: {
        'Email': _emailController,
        'Password': _passwordController,
      },
      forgotPassword: true,
      title: 'Log In',
      description: 'Welcome back, we missed you.',
      buttonLabel: 'LOGIN',
      onPressed: () {
        if (formKey.currentState!.validate()) {
          setState(() {
            isPressed = true;
          });
          String email = _emailController.text;
          String password = _passwordController.text;
          Navigator.pushNamed(context, AppRoutes.homeRoute);
          BlocProvider.of<AuthenticationCubit>(context).login(
            email: email,
            password: password,
            context: context,
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/route/routes.dart';
import 'package:musync/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:musync/features/auth/presentation/widgets/auth_page_component.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController =
      TextEditingController(text: "alexxy");
  final TextEditingController _emailController =
      TextEditingController(text: "aayushpandey616@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "VerySecretPassword@100");
  final TextEditingController _cPasswordController =
      TextEditingController(text: "VerySecretPassword@100");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _cPasswordController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignupButtonPressed(BuildContext context) {
    if (formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      BlocProvider.of<AuthenticationCubit>(context).signup(
        email: email,
        password: password,
        username: username,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthComponent(
      redirectRoute: AppRoutes.loginRoute,
      redirectLabel: 'Login',
      canBack: true,
      fromKey: formKey,
      backRoute: AppRoutes.getStartedRoute,
      darkMode: MediaQuery.of(context).platformBrightness == Brightness.dark,
      controllersMap: {
        'Username': _usernameController,
        "Email": _emailController,
        'Password': _passwordController,
        "Confirm Password": _cPasswordController,
      },
      forgotPassword: false,
      title: 'Sign Up',
      description: 'Sign up to Musync to get started on all platforms.',
      buttonLabel: 'SIGNUP',
      onPressed: () => _handleSignupButtonPressed(context),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:musync/features/auth/presentation/widgets/auth_page_component.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "aayushpandey616@gmail.com");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthComponent(
      canBack: true,
      fromKey: formKey,
      darkMode: MediaQuery.of(context).platformBrightness == Brightness.dark,
      controllersMap: {
        'Email': _emailController,
      },
      forgotPassword: true,
      title: 'Forgot Password',
      description: 'Its alright bud we got you.',
      buttonLabel: 'CONTINUE',
      onPressed: () {
        if (formKey.currentState!.validate()) {
          String email = _emailController.text;
          BlocProvider.of<AuthenticationCubit>(context).sendForgetPasswordOTP(
            email: email,
            context: context,
          );
        }
      },
    );
  }
}

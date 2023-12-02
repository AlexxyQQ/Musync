import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:musync/features/auth/presentation/widgets/auth_page_component.dart';

class ChangePasswordPage extends StatefulWidget {
  final String email;
  const ChangePasswordPage({
    super.key,
    required this.email,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController =
      TextEditingController(text: "VerySecretPassword@100");
  final TextEditingController _cPasswordController =
      TextEditingController(text: "VerySecretPassword@100");

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (index) => TextEditingController());
    focusNodes = List.generate(
      6,
      (index) => FocusNode(),
    );
  }

  String getOTPCode() {
    return controllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthComponent(
      canBack: true,
      fromKey: formKey,
      darkMode: MediaQuery.of(context).platformBrightness == Brightness.dark,
      controllersMap: {
        'Password': _passwordController,
        'Confirm Password': _cPasswordController,
      },
      forgotPassword: false,
      backRoute: AppRoutes.loginRoute,
      title: 'Change Password',
      description: 'Its alright bud we got you.',
      buttonLabel: 'CONTINUE',
      optController: controllers,
      focusNodes: focusNodes,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          String password = _passwordController.text;
          String cPassword = _cPasswordController.text;
          BlocProvider.of<AuthenticationCubit>(context).changePassword(
            confirmNewPassword: cPassword,
            newPassword: password,
            context: context,
            email: widget.email,
            otp: getOTPCode(),
          );
        }
      },
    );
  }
}

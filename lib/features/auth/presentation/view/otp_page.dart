import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/route/routes.dart';
import 'package:musync/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:musync/features/auth/presentation/widgets/auth_page_component.dart';

class OTPPage extends StatefulWidget {
  final String email;
  const OTPPage({
    super.key,
    required this.email,
  });

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
      controllersMap: const {},
      forgotPassword: false,
      backRoute: AppRoutes.loginRoute,
      title: 'OTP Verification',
      description: 'Almost there.',
      buttonLabel: 'CONTINUE',
      optController: controllers,
      focusNodes: focusNodes,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          log(
            'OTP: ${getOTPCode()}',
            name: 'OTP',
          );
          BlocProvider.of<AuthenticationCubit>(context).otpValidator(
            email: widget.email,
            otp: getOTPCode(),
            context: context,
          );
        }
      },
    );
  }
}

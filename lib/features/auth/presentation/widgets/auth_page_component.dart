import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/core/utils/text_theme_extension.dart';
import 'package:musync/core/utils/titlecase_extinsion.dart';

import '../../../../config/constants/constants.dart';
import '../../../../config/router/routers.dart';
import '../../../../core/common/custom_widgets/custom_buttom.dart';
import '../../../../core/common/custom_widgets/custom_form_filed.dart';
import '../../../../core/common/static_loader.dart';
import '../cubit/authentication_cubit.dart';
import '../cubit/authentication_state.dart';

/// AuthComponent - A Custom Authentication Component for Flutter Applications.
///
/// This component provides a customizable user interface for authentication purposes,
/// including login, registration, and password reset functionalities. It's designed
/// to be easily integrated into Flutter applications that require user authentication.
///
/// Parameters:
///   [fromKey] - GlobalKey<FormState> that is used to control the form within the component.
///   [darkMode] - (Optional) A bool value to toggle dark mode for the component's UI.
///   [canBack] - (Optional) A bool value to enable or disable a back navigation button.
///   [redirectRoute] - (Optional) A String value that specifies the route to redirect to.
///   [redirectLabel] - (Optional) A String label for the redirection option.
///   [formMessage] - (Optional) A String message to be displayed on the form.
///   [controllersMap] - A Map of String and TextEditingController for form fields.
///   [optController] - (Optional) A List of TextEditingController for OTP fields.
///   [buttonLabel] - A String label for the main action button.
///   [onPressed] - A Function callback for the button press action.
///   [forgotPassword] - (Optional) A bool value to enable or disable forgot password feature.
///   [title] - A String title for the component.
///   [description] - A String description for the component.
///   [focusNodes] - (Optional) A List of FocusNode for managing focus in the form fields.
///   [backRoute] - (Optional) A String value specifying the back navigation route.
///
/// Example Usage:
/// ```dart
/// AuthComponent(
///   fromKey: _formKey,
///   darkMode: true,
///   canBack: true,
///   controllersMap: {
///     'Email': _emailController,
///     'Password': _passwordController,
///   },
///   buttonLabel: 'Login',
///   onPressed: _handleLogin,
///   title: 'Welcome Back',
///   description: 'Login to your account',
/// )
/// ```
///
/// Note: Make sure to provide all the required parameters and manage the state of controllers
/// and focus nodes as needed in your parent widget.
class AuthComponent extends StatefulWidget {
  final GlobalKey<FormState> fromKey;
  final bool? darkMode;
  final bool? canBack;
  final String? redirectRoute;
  final String? redirectLabel;
  final String? formMessage;
  final Map<String, TextEditingController>? controllersMap;
  final List<TextEditingController>? optController;
  final String buttonLabel;
  final void Function() onPressed;
  final bool? forgotPassword;
  final String title;
  final String description;
  final List<FocusNode>? focusNodes;
  final String? backRoute;
  const AuthComponent({
    Key? key,
    required this.fromKey,
    required this.buttonLabel,
    required this.onPressed,
    required this.title,
    required this.description,
    this.controllersMap,
    this.darkMode,
    this.canBack,
    this.redirectRoute,
    this.redirectLabel,
    this.formMessage,
    this.optController,
    this.forgotPassword,
    this.focusNodes,
    this.backRoute,
  }) : super(key: key);

  @override
  State<AuthComponent> createState() => _AuthComponentState();
}

class _AuthComponentState extends State<AuthComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBar(
        leading: widget.canBack != null && widget.canBack!
            ? IconButton(
                onPressed: () {
                  widget.backRoute == null
                      ? Navigator.of(context).pop()
                      : Navigator.of(context).pushNamed(widget.backRoute!);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
              )
            : const SizedBox.shrink(),
        actions: [
          widget.redirectRoute != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(widget.redirectRoute!);
                    },
                    child: Text(
                      widget.redirectLabel!,
                      style: Theme.of(context).textTheme.f14W6,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            reverse: true,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                decoration: BoxDecoration(
                  color: widget.darkMode != null && widget.darkMode!
                      ? AppBackgroundColor.darkDim
                      : AppBackgroundColor.dark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyForm(
                        darkMode: widget.darkMode,
                        controllersMap: widget.controllersMap,
                        fromKey: widget.fromKey,
                        optController: widget.optController,
                        formMessage: widget.formMessage,
                        focusNodes: widget.focusNodes,
                      ),
                      // Forgot Password
                      widget.forgotPassword != null && widget.forgotPassword!
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.forgotPasswordRoute,
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: widget.darkMode != null &&
                                              widget.darkMode!
                                          ? Theme.of(context).textTheme.f12W4D
                                          : Theme.of(context).textTheme.f12W4L,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      SizedBox(height: 20.h),
                      //  Button
                      KButton(
                        onPressed: widget.onPressed,
                        label: widget.buttonLabel,
                        darkBackgroundColor: AppBackgroundColor.light,
                        lightBackgroundColor: AppBackgroundColor.dark,
                        darkForegroundColor: AppTextColor.dark,
                        lightForegroundColor: AppTextColor.light,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.87,
                          40.h,
                        ),
                        borderRadius: 32.r,
                      ),
                      SizedBox(height: 20.h),
                      // Terms and Conditions and Privacy Policy
                      TermsAndConditions(
                        darkMode: widget.darkMode,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Title and Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title.titleCase,
                      style: Theme.of(context).textTheme.f28W7,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.f14W4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Loader

          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Loader();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
    required this.darkMode,
  });

  final bool? darkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By signing up, you agree to our ',
          style: darkMode != null && darkMode!
              ? Theme.of(context).textTheme.f10W3D
              : Theme.of(context).textTheme.f10W3LDi,
          children: [
            TextSpan(
              text: 'Terms and Conditions',
              style: darkMode != null && darkMode!
                  ? Theme.of(context).textTheme.f10W3D
                  : Theme.of(context).textTheme.f10W3LDi,
            ),
            TextSpan(
              text: ' and ',
              style: darkMode != null && darkMode!
                  ? Theme.of(context).textTheme.f10W3D
                  : Theme.of(context).textTheme.f10W3LDi,
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: darkMode != null && darkMode!
                  ? Theme.of(context).textTheme.f10W3D
                  : Theme.of(context).textTheme.f10W3LDi,
            ),
          ],
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  final bool? darkMode;
  final Map<String, TextEditingController>? controllersMap;
  final List<TextEditingController>? optController;
  final String? formMessage;
  final GlobalKey<FormState> fromKey;
  final List<FocusNode>? focusNodes;

  const MyForm({
    Key? key,
    required this.darkMode,
    this.controllersMap,
    this.optController,
    this.formMessage,
    required this.fromKey,
    this.focusNodes,
  }) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  var _obstructText = true;
  var _obstructTextC = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.fromKey,
      child: Column(
        children: [
          // Form Message
          if (widget.formMessage != null)
            Text(
              widget.formMessage!,
              style: widget.darkMode != null && widget.darkMode!
                  ? Theme.of(context).textTheme.f12W4D
                  : Theme.of(context).textTheme.f12W4LDi,
            ),
          SizedBox(height: 20.h),
          // Form Fields
          _buildFormFields(context),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          if (widget.controllersMap != null)
            ...widget.controllersMap!.entries
                .map((e) => _buildTextField(e, context)),
          if (widget.optController != null && widget.optController!.isNotEmpty)
            _buildOTPFields(),
        ],
      ),
    );
  }

  Widget _buildTextField(
    MapEntry<String, TextEditingController> entry,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: KTextFormField(
        hintText: entry.key,
        fillColor: widget.darkMode != null && widget.darkMode!
            ? AppBackgroundColor.dark
            : AppBackgroundColor.light,
        contentStyle: widget.darkMode != null && widget.darkMode!
            ? Theme.of(context).textTheme.f14W4L
            : Theme.of(context).textTheme.f14W4D,
        hintTextStyle: widget.darkMode != null && widget.darkMode!
            ? Theme.of(context).textTheme.f12W3LDi
            : Theme.of(context).textTheme.f12W3D,
        errorTextStyle: Theme.of(context).textTheme.f12W3D.copyWith(
              color: AppAccentColor.red,
            ),
        controller: entry.value,
        obscureText: entry.key == 'Password'
            ? _obstructText
            : entry.key == 'Confirm Password'
                ? _obstructTextC
                : false,
        validator: (value) => _validateField(entry.key, value),
        onSuffixTap: () => onSuffixTap(entry.key),
        prefixIcon: prefixIcon(entry.key),
        suffixIcon: suffixIcon(entry.key),
        keyboardType: keyboardType(entry.key),
      ),
    );
  }

  TextInputType keyboardType(String? key) {
    if (key == 'Email') {
      return TextInputType.emailAddress;
    }
    if (key == 'Password' || key == 'Confirm Password') {
      return TextInputType.visiblePassword;
    }
    return TextInputType.name;
  }

  Widget? suffixIcon(String? key) {
    if (key == 'Password') {
      return _obstructText
          ? Icon(
              Icons.visibility_rounded,
              color: widget.darkMode != null && widget.darkMode!
                  ? AppIconColor.light
                  : AppIconColor.dark,
            )
          : Icon(
              Icons.visibility_off_rounded,
              color: widget.darkMode != null && widget.darkMode!
                  ? AppIconColor.light
                  : AppIconColor.dark,
            );
    }
    if (key == 'Confirm Password') {
      return _obstructTextC
          ? Icon(
              Icons.visibility_rounded,
              color: widget.darkMode != null && widget.darkMode!
                  ? AppIconColor.light
                  : AppIconColor.dark,
            )
          : Icon(
              Icons.visibility_off_rounded,
              color: widget.darkMode != null && widget.darkMode!
                  ? AppIconColor.light
                  : AppIconColor.dark,
            );
    }
    return null;
  }

  Widget? prefixIcon(String? key) {
    if (key == 'Email') {
      return Icon(
        Icons.email_outlined,
        color: widget.darkMode != null && widget.darkMode!
            ? AppIconColor.light
            : AppIconColor.dark,
      );
    }
    if (key == 'Password' || key == 'Confirm Password') {
      return Icon(
        Icons.lock_outline_rounded,
        color: widget.darkMode != null && widget.darkMode!
            ? AppIconColor.light
            : AppIconColor.dark,
      );
    }
    if (key == "Username") {
      return Icon(
        Icons.person_outline_rounded,
        color: widget.darkMode != null && widget.darkMode!
            ? AppIconColor.light
            : AppIconColor.dark,
      );
    }
    return null;
  }

  onSuffixTap(String? key) {
    if (key == 'Password') {
      log('Password');
      setState(() {
        _obstructText = !_obstructText;
      });
    }

    if (key == 'Confirm Password') {
      setState(() {
        _obstructTextC = !_obstructTextC;
      });
    }
  }

  String? _validateField(String key, String? value) {
    if (key == 'Email') {
      if (value!.isEmpty) {
        return 'Email is required';
      } else if (!RegExp(
        r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))'
        r'@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$',
      ).hasMatch(value)) {
        return 'Email is invalid';
      }
      return null;
    }
    if (key == 'Username') {
      if (value!.isEmpty) {
        return 'Username is required';
      }
    }
    if (key == 'Password') {
      if (value!.isEmpty) {
        return 'Password is required';
      } else if (value.length < 8) {
        return 'Password must be at least 8 characters';
      } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
        return 'Password must contain at least one uppercase letter';
      } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
        return 'Password must contain at least one lowercase letter';
      } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
        return 'Password must contain at least one number';
      } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
        return 'Password must contain at least one special character';
      }
      return null;
    }
    if (key == 'Confirm Password') {
      if (value!.isEmpty) {
        return 'Password is required';
      } else if (value.length < 8) {
        return 'Password must be at least 8 characters';
      } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
        return 'Password must contain at least one uppercase letter';
      } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
        return 'Password must contain at least one lowercase letter';
      } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
        return 'Password must contain at least one number';
      } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
        return 'Password must contain at least one special character';
      } else if (value != widget.controllersMap!['Password']?.text) {
        return 'Confirm Password must be same as Password';
      }
      return null;
    }
    return null;
  }

  Widget _buildOTPFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.optController!.map((controller) {
        return SizedBox(
          width: 50.w,
          height: 40.h,
          child: KTextFormField(
            textAlign: TextAlign.center,
            controller: controller,
            fillColor: widget.darkMode != null && widget.darkMode!
                ? AppBackgroundColor.dark
                : AppBackgroundColor.light,
            contentStyle: widget.darkMode != null && widget.darkMode!
                ? Theme.of(context).textTheme.f14W4L
                : Theme.of(context).textTheme.f14W4D,
            hintTextStyle: widget.darkMode != null && widget.darkMode!
                ? Theme.of(context).textTheme.f12W3LDi
                : Theme.of(context).textTheme.f12W3D,
            errorTextStyle: Theme.of(context).textTheme.f12W3D.copyWith(
                  color: AppAccentColor.red,
                ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value != null) {
                if (value.isEmpty) {
                  // Handle backspace or delete key
                  FocusScope.of(context).previousFocus();
                } else if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              }
            },
            onEditingComplete: () {
              if (controller.text.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            },
            focusNode:
                widget.focusNodes![widget.optController!.indexOf(controller)],
          ),
        );
      }).toList(),
    );
  }
}

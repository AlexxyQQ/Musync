// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/common/formfiled.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "aayushpandey616@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "VerySecretPassword@100");

  bool isPressed = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      BlocProvider.of<AuthViewModel>(context).checkDeviceSupportForBiometrics();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      appBar: AppBar(
        backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 100,
        // Back Button
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.getStartedRoute);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark ? KColors.whiteColor : KColors.blackColor,
          ),
        ),
        actions: [
          // Register Button
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.signupRoute,
                (route) => false,
              );
            },
            child: Text(
              'Register',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: constraints.maxHeight < MediaQuery.of(context).size.height
                ? null
                : const NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Login Texts
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 80,
                      maxWidth: mediaQuerySize.width,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Login Text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Log In',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 40,
                                ),
                          ),
                        ),
                        // Welcome back Text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Welcome back, we missed you',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Login Form
                  Container(
                    height: mediaQuerySize.height * 0.5,
                    width: mediaQuerySize.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isDark ? KColors.whiteColor : KColors.blackColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: BlocConsumer<AuthViewModel, AuthState>(
                      listener: (context, state) {
                        if (state.isError) {
                          kShowSnackBar(
                            state.authError!,
                            context: context,
                          );
                        }
                        if (state.isLogin) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.homeRoute,
                            (route) => false,
                            arguments: {
                              "selectedIndex": 0,
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        return Stack(
                          children: [
                            if (state.isLoading)
                              authLoading(mediaQuerySize, context),
                            LoginForm(
                              formKey: formKey,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isPressed = true;
                                  });
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  BlocProvider.of<AuthViewModel>(context)
                                      .loginUser(
                                    email: email,
                                    password: password,
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Center authLoading(Size mediaQuerySize, BuildContext context) {
    return Center(
      child: Container(
        height: mediaQuerySize.height * 0.2,
        width: mediaQuerySize.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: KColors.whiteColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required this.onPressed,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super();

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Email Text Form Field
          CTextFormFiled(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email',
            labelText: 'Email',
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Email is required';
              } else if (!RegExp(
                r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$',
              ).hasMatch(p0)) {
                return 'Email is invalid';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Password Text Form Field
          CPasswordFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Password',
            labelText: 'Password',
            obscureText: true,
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Password is required';
              } else if (p0.length < 8) {
                return 'Password must be at least 8 characters';
              } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(p0)) {
                return 'Password must contain at least one uppercase letter';
              } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(p0)) {
                return 'Password must contain at least one lowercase letter';
              } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(p0)) {
                return 'Password must contain at least one number';
              } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(p0)) {
                return 'Password must contain at least one special character';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Forgot Password Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.forgotPasswordRoute,
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 15,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? KColors.blackColor
                            : KColors.whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Login Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: KColors.accentColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: Size(
                MediaQuery.of(context).size.width,
                50,
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                onPressed();
              }
            },
            child: Text(
              'LOGIN',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          // Login with Finger Print
          BlocProvider.of<AuthViewModel>(context).state.supportBioMetricState &&
                  BlocProvider.of<AuthViewModel>(context)
                      .state
                      .allowLoginWithBiometric
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KColors.blackColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(
                      100,
                      50,
                    ),
                  ),
                  onPressed: () async {
                    final t = await GetIt.instance<HiveQueries>().getValue(
                      boxName: 'users',
                      key: 'anotherToken',
                      defaultValue: '',
                    );
                    if (t != null || t != "") {
                      await BlocProvider.of<AuthViewModel>(context)
                          .authenticateWithBiometrics();
                      if (BlocProvider.of<AuthViewModel>(context)
                              .state
                              .loggedUser!
                              .username !=
                          "Guest") {
                        Navigator.popAndPushNamed(context, AppRoutes.homeRoute);
                      }
                    } else {
                      kShowSnackBar('Please login first', context: context);
                    }
                  },
                  child: const Icon(
                    Icons.fingerprint,
                    color: KColors.accentColor,
                    size: 30,
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 20),
          // Terms and Conditions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "By continuing, you’re agreeing to Musync Privacy policy and Terms of use.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 15,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                    fontWeight: FontWeight.w400,
                  ),

              // style: GlobalConstants.textStyle(
              //   family: 'Sans',
              //   fontSize: 15,
              //   color: isDark ? KColors.blackColor : KColors.whiteColor,
              //   fontWeight: FontWeight.w500,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

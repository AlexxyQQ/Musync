import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musync/src/authentication/data/providers/authentication_provider.dart';
import 'package:musync/src/authentication/data/providers/user_provider.dart';
import 'package:musync/src/common/formfiled.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernmaeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? blackColor : whiteColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 100,
        backgroundColor: isDark ? blackColor : whiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/welcome');
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark ? whiteColor : blackColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            child: Text(
              'Login',
              style: textStyle(
                fontSize: 18,
                color: isDark ? whiteColor : blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
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
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100,
                    maxWidth: mediaQuerySize.width,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // SignUp
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Sign Up',
                          style: textStyle(
                            fontSize: 40,
                            color: isDark ? whiteColor : blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // SignUp Description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Sign up to Musync to get started on all platforms.',
                          style: textStyle(
                            fontSize: 16,
                            color: isDark ? whiteColor : blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Signup Form
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: mediaQuerySize.width,
                    height: mediaQuerySize.height * 0.65,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: isDark ? whiteColor : blackColor,
                    ),
                    child: SignupForm(
                      formKey: _formKey,
                      usernmaeController: _usernmaeController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      cPasswordController: _cPasswordController,
                      ref: ref,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController usernmaeController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController cPasswordController,
    required this.ref,
  })  : _formKey = formKey,
        _usernmaeController = usernmaeController,
        _emailController = emailController,
        _passwordController = passwordController,
        _cPasswordController = cPasswordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _usernmaeController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _cPasswordController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Username
          CTextFormFiled(
            controller: _usernmaeController,
            keyboardType: TextInputType.emailAddress,
            fillColor: isDark ? offBlackColor : whiteColor,
            hintText: 'Username',
            labelText: 'Username',
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'USername is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Email
          CTextFormFiled(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            fillColor: isDark ? offBlackColor : whiteColor,
            hintText: 'Email',
            labelText: 'Email',
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Email is required';
              } else if (!RegExp(
                      r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$')
                  .hasMatch(p0)) {
                return 'Email is invalid';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          //  Password
          CPasswordFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Password',
            labelText: 'Password',
            fillColor: isDark ? offBlackColor : whiteColor,
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
          // Confirm Password
          CPasswordFormField(
            controller: _cPasswordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Confirm Password',
            labelText: 'Confirm Password',
            fillColor: isDark ? offBlackColor : whiteColor,
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
              } else if (p0 != _passwordController.text) {
                return 'Password does not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
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
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final navigator = Navigator.of(context);
                final sMessenger = ScaffoldMessenger.of(context);
                final errorModel =
                    await ref.read(authenticationProvider).signUpManual(
                          email: _emailController.text.toLowerCase(),
                          password: _passwordController.text,
                          username: _usernmaeController.text,
                          confirmPassword: _cPasswordController.text,
                          type: 'manual',
                        );
                if (errorModel.error == null) {
                  sMessenger.showSnackBar(
                    const SnackBar(
                      content: Text('User created successfully'),
                    ),
                  );
                  ref
                      .read(userProvider.notifier)
                      .update((state) => errorModel.data);
                  navigator.pushNamedAndRemoveUntil(
                    '/welcome',
                    (route) => false,
                  );
                } else {
                  sMessenger.showSnackBar(
                    SnackBar(
                      content: Text(errorModel.error!),
                    ),
                  );
                }
              }
            },
            child: Text(
              'SIGN UP',
              style: textStyle(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "By continuing, you’re agreeing to Musync Privacy policy and Terms of use.",
              textAlign: TextAlign.center,
              style: textStyle(
                family: 'Sans',
                fontSize: 15,
                color: isDark ? blackColor : whiteColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

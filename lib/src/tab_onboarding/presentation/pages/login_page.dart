import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musync/src/authentication/data/providers/authentication_provider.dart';
import 'package:musync/src/authentication/data/providers/user_provider.dart';
import 'package:musync/src/common/data/repositories/local_storage_repository.dart';
import 'package:musync/src/common/formfiled.dart';
import 'package:musync/src/home/presentation/pages/home.dart';
import 'package:musync/src/music_library/data/providers/song_provider.dart';
import 'package:musync/src/music_library/presentation/pages/library_page.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';

class TabLoginPage extends ConsumerStatefulWidget {
  const TabLoginPage(
      {super.key, required this.updateIsLogin, required this.updateIsSignup});

  final Function(bool) updateIsLogin;
  final Function(bool) updateIsSignup;

  @override
  ConsumerState<TabLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<TabLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
        backgroundColor: isDark ? blackColor : whiteColor,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 100,
        // Back Button
        leading: IconButton(
          onPressed: () {
            widget.updateIsSignup(false);
            widget.updateIsLogin(false);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark ? whiteColor : blackColor,
          ),
        ),
        actions: [
          // Register Button
          TextButton(
            onPressed: () {
              widget.updateIsLogin(false);
              widget.updateIsSignup(true);
            },
            child: Text(
              'Register',
              style: textStyle(
                fontSize: 18,
                color: isDark ? whiteColor : blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: SizedBox(
          height: mediaQuerySize.height,
          width: mediaQuerySize.width,
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
                        style: textStyle(
                          color: isDark ? whiteColor : blackColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Welcome back Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Welcome back, we missed you',
                        style: textStyle(
                          color: isDark ? whiteColor : blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Login Form
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: mediaQuerySize.height * 0.5,
                  width: mediaQuerySize.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isDark ? whiteColor : blackColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: LoginForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    ref: ref,
                  ),
                ),
              ),
            ],
          ),
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
    required this.ref,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
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
          // Email Text Form Field
          CTextFormFiled(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email',
            labelText: 'Email',
            fillColor: isDark ? blackColor : offWhiteColor,
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
          // Password Text Form Field
          CPasswordFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Password',
            labelText: 'Password',
            fillColor: isDark ? blackColor : offWhiteColor,
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
                    '/forgotpassword',
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: textStyle(
                    color: isDark ? offBlackColor : whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Login Button
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
                    await ref.read(authenticationProvider).signInManual(
                          email: _emailController.text.toLowerCase(),
                          password: _passwordController.text,
                        );
                if (errorModel.error == null) {
                  sMessenger.showSnackBar(
                    const SnackBar(
                      content: Text("Login Success"),
                    ),
                  );
                  LocalStorageRepository().setValue(
                      boxName: 'settings', key: "goHome", value: true);
                  ref
                      .read(userProvider.notifier)
                      .update((state) => errorModel.data);
                  await ref.read(songProvider).permission();
                  navigator.pushNamedAndRemoveUntil(
                    '/home',
                    (route) => false,
                    arguments: {
                      "pages": [
                        // Home Page
                        const HomePage(),
                        // IDK
                        const Placeholder(),
                        // Library Page
                        const LibraryPage()
                      ],
                      "selectedIndex": 0,
                    },
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
              'LOGIN',
              style: textStyle(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Terms and Conditions
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/common/common_widgets/custom_snackbar.dart';
import 'package:musync/common/local_storage_repository.dart';
import 'package:musync/constants/constants.dart';
import 'package:musync/constants/enums.dart';
import 'package:musync/features/authentication/bloc/authentication_bloc.dart';
import 'package:musync/features/authentication/bloc/authentication_bloc.dart';
import 'package:musync/features/authentication/repositories/user_repositories.dart';
import 'package:musync/routes/routers.dart';

class MainAuthPage extends StatefulWidget {
  const MainAuthPage({super.key});

  @override
  State<MainAuthPage> createState() => _MainAuthPageState();
}

class _MainAuthPageState extends State<MainAuthPage> {
  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      body: Column(
        children: [
          // Logo and App Name
          LogoAndAppName(mediaQuerySize: mediaQuerySize, isDark: isDark),
          // Login and Signup Button
          LoginSignupButton(isDark: isDark, mediaQuerySize: mediaQuerySize),
        ],
      ),
    );
  }
}

class LoginSignupButton extends StatelessWidget {
  const LoginSignupButton({
    super.key,
    required this.isDark,
    required this.mediaQuerySize,
  });

  final bool isDark;
  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: isDark ? KColors.whiteColor : KColors.blackColor,
      ),
      height: mediaQuerySize.height / 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Text
            Text(
              'Welcome to Musync',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 32,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                  ),
            ),
            // Description Text
            const SizedBox(height: 6),
            Text(
              'Musync is a music streaming app that allows you to listen to your favorite music and share it with your friends.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                  ),
            ),
            const SizedBox(height: 30),
            // Login and Signup Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/login');
                  },
                  child: Text(
                    'LOGIN',
                    style: GlobalConstants.textStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark ? KColors.whiteColor : KColors.blackColor,
                    ),
                  ),
                ),
                // Signup Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/signup');
                  },
                  child: Text(
                    'SIGN UP',
                    style: GlobalConstants.textStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark ? KColors.whiteColor : KColors.blackColor,
                    ),
                  ),
                ),
                // Google Sign In Button
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state.status == Status.success) {
                      kShowSnackBar(
                        "Logged in successfully!",
                        context: context,
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.homeRoute,
                        (route) => false,
                      );
                    }
                    if (state.status == Status.error) {
                      kShowSnackBar(state.message!, context: context);
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () async {
                      // ! UNCOMMENT THIS TO ENABLE GOOGLE SIGN IN
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        GoogleEvent(),
                      );
                    },
                    child: Image.asset(
                      'assets/icons/google.png',
                      height: 28,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Get Started Offline Button
            Center(
              child: TextButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  LocalStorageRepository().setValue(
                    boxName: 'settings',
                    key: "goHome",
                    value: true,
                  );
                  // await ref.read(songProvider).permission();
                  navigator.pushNamedAndRemoveUntil(
                    Routes.homeRoute,
                    (route) => false,
                    arguments: {
                      "pages": [
                        // Home Page
                        const Placeholder(),
                        // IDK
                        const Placeholder(),
                        // Library Page
                        const Placeholder()
                      ],
                      "selectedIndex": 0,
                    },
                  );
                },
                child: Text(
                  'Get Started Offline',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? KColors.blackColor
                            : KColors.whiteColor,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Google Sign In Button
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'By Continue, you’re agree to Musync Privacy policy and Terms of use.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? KColors.blackColor
                            : KColors.whiteColor,
                      ),
                  // style: TextStyle(
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w600,
                  //   color: isDark ? KColors.blackColor : KColors.whiteColor,
                  // ),
                  // style: GlobalConstants.textStyle(
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.w400,
                  //   color: isDark ? KColors.blackColor : KColors.whiteColor,
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoAndAppName extends StatelessWidget {
  const LogoAndAppName({
    super.key,
    required this.mediaQuerySize,
    required this.isDark,
  });

  final Size mediaQuerySize;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Image.asset(
            'assets/splash_screen/Logo.png',
            height: 80,
          ),
          // App Name
          Text(
            'Musync',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 40,
                ),
            // style: GlobalConstants.textStyle(
            //   color: isDark ? KColors.whiteColor : KColors.blackColor,
            //   fontSize: 40,
            //   fontWeight: FontWeight.w700,
            // ),
          ),
          const SizedBox(height: 10),
          // App Description
          Text(
            'Sync up and tune in with Musync - your ultimate music companion.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
            // style: GlobalConstants.textStyle(
            //   color: isDark ? KColors.whiteColor : KColors.blackColor,
            //   fontSize: 20,
            //   fontWeight: FontWeight.w400,
            // ),
          ),
        ],
      ),
    );
  }
}

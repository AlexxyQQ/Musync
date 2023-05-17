import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musync/src/authentication/data/providers/authentication_provider.dart';
import 'package:musync/src/authentication/data/providers/user_provider.dart';
import 'package:musync/src/common/data/repositories/local_storage_repository.dart';
import 'package:musync/src/home/presentation/pages/home.dart';
import 'package:musync/src/music_library/data/providers/song_provider.dart';
import 'package:musync/src/music_library/presentation/pages/library_page.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';

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
      backgroundColor: isDark ? blackColor : whiteColor,
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
        color: isDark ? whiteColor : blackColor,
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
              style: textStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: isDark ? blackColor : whiteColor,
              ),
            ),
            // Description Text
            const SizedBox(height: 6),
            Text(
              'Musync is a music streaming app that allows you to listen to your favorite music and share it with your friends.',
              style: textStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: isDark ? blackColor : whiteColor,
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(110, 60),
                    backgroundColor: isDark ? offBlackColor : offWhiteColor,
                  ),
                  child: Text(
                    'LOGIN',
                    style: textStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark ? whiteColor : blackColor,
                    ),
                  ),
                ),
                // Signup Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(110, 60),
                    backgroundColor: isDark ? offBlackColor : offWhiteColor,
                  ),
                  child: Text(
                    'SIGN UP',
                    style: textStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark ? whiteColor : blackColor,
                    ),
                  ),
                ),
                // Google Sign In Button
                Consumer(
                  builder: (context, ref, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(110, 60),
                        backgroundColor: isDark ? offBlackColor : offWhiteColor,
                      ),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final sMessenger = ScaffoldMessenger.of(context);
                        final errorModel = await ref
                            .read(authenticationProvider)
                            .signUpGoogle();
                        if (errorModel.error == null) {
                          await LocalStorageRepository().setValue(
                            boxName: 'settings',
                            key: "goHome",
                            value: true,
                          );
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
                      },
                      child: Image.asset(
                        'assets/icons/google.png',
                        height: 28,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Get Started Offline Button
            Consumer(builder: (context, ref, child) {
              return Center(
                child: TextButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    LocalStorageRepository().setValue(
                        boxName: 'settings', key: "goHome", value: true);
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
                  },
                  child: Text(
                    'Get Started Offline',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? blackColor : whiteColor,
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            // Google Sign In Button
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'By Continue, you’re agree to Musync Privacy policy and Terms of use.',
                  textAlign: TextAlign.center,
                  style: textStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: isDark ? blackColor : whiteColor,
                  ),
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
            style: textStyle(
              color: isDark ? whiteColor : blackColor,
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          // App Description
          Text(
            'Sync up and tune in with Musync - your ultimate music companion.',
            textAlign: TextAlign.center,
            style: textStyle(
              color: isDark ? whiteColor : blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

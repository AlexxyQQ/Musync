
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/custom_widgets/custom_buttom.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';
import 'package:musync/config/route/routes.dart';
import 'package:musync/injection/app_injection_container.dart';

class MainAuthPage extends StatefulWidget {
  const MainAuthPage({super.key});

  @override
  State<MainAuthPage> createState() => _MainAuthPageState();
}

class _MainAuthPageState extends State<MainAuthPage> {
  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // Logo and App Name
          LogoAndAppName(
            mediaQuerySize: mediaQuerySize,
          ),
          // Login and Signup Button
          LoginSignupButton(mediaQuerySize: mediaQuerySize),
        ],
      ),
    );
  }
}

class LoginSignupButton extends StatelessWidget {
  const LoginSignupButton({
    super.key,
    required this.mediaQuerySize,
  });

  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: AppColors(inverseDarkMode: true).background,
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
              style: Theme.of(context).textTheme.h4.copyWith(
                    color: AppColors(inverseDarkMode: true).onBackground,
                  ),
            ),
            // Description Text
            const SizedBox(height: 6),
            Text(
              'Musync is a music streaming app that allows you to listen to your favorite music and share it with your friends.',
              style: Theme.of(context).textTheme.mBM.copyWith(
                    color: AppColors(inverseDarkMode: true).onBackground,
                  ),
            ),
            const SizedBox(height: 30),
            // Login and Signup Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Login Button
                KButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed(AppRoutes.loginRoute);
                  },
                  label: 'LOGIN',
                  borderRadius: 32,
                  fixedSize: const Size(110, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),

                KButton(
                  onPressed: () {
                    Navigator.of(context)
                        .popAndPushNamed(AppRoutes.signupRoute);
                  },
                  label: 'SIGN UP',
                  borderRadius: 32,
                  fixedSize: const Size(110, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),

                // Google Sign In Button
                KButton(
                  onPressed: () {
                    Navigator.of(context)
                        .popAndPushNamed(AppRoutes.signupRoute);
                  },
                  svg: 'assets/icons/Google-Colored.svg',
                  borderRadius: 32,
                  fixedSize: const Size(110, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // Get Started Offline Button
            Center(
              child: InkWell(
                onTap: () async {
                  final navigator = Navigator.of(context);
                  final setting =
                      await get<SettingsHiveService>().getSettings();
                  await get<SettingsHiveService>().updateSettings(
                    setting.copyWith(
                      goHome: true,
                    ),
                  );
                  final setting2 =
                      await get<SettingsHiveService>().getSettings();
                  // await ref.read(songProvider).permission();
                  navigator.pushNamedAndRemoveUntil(
                    AppRoutes.homeRoute,
                    (route) => false,
                    arguments: {
                      "selectedIndex": 0,
                    },
                  );
                },
                child: Text(
                  'Get Started Offline',
                  style: Theme.of(context).textTheme.mBM.copyWith(
                        color: AppColors(inverseDarkMode: true).onBackground,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Google Sign In Button
            Center(
              child: Text(
                "By continuing, you’re agreeing to \n Musync Privacy Policy and Terms of use.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.lC.copyWith(
                      color: AppColors(inverseDarkMode: true).onSurfaceVariant,
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
  });

  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            SvgPicture.asset(
              'assets/splash_screen/Logo.svg',
              height: 80,
            ),
            // App Name
            Text('Musync', style: Theme.of(context).textTheme.h1),
            const SizedBox(height: 12),
            // App Description
            Text(
              'Sync up and tune in with Musync - your ultimate music companion.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.mBL,
            ),
          ],
        ),
      ),
    );
  }
}

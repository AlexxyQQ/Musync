import 'package:flutter/material.dart';
import 'package:musync/src/tab_onboarding/presentation/pages/login_page.dart';
import 'package:musync/src/tab_onboarding/presentation/pages/main_auth_page.dart';
import 'package:musync/src/tab_onboarding/presentation/pages/on_boarding_page.dart';
import 'package:musync/src/tab_onboarding/presentation/pages/signup_page.dart';

class TabOnboarding extends StatefulWidget {
  const TabOnboarding({super.key});

  @override
  State<TabOnboarding> createState() => _TabOnboardingState();
}

class _TabOnboardingState extends State<TabOnboarding> {
  bool isLogin = false;
  bool isSignup = false;

  void updateIsLogin(bool newValue) {
    setState(() {
      isLogin = newValue;
    });
  }

  void updateIsSignup(bool newValue) {
    setState(() {
      isSignup = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: TabOnBoardingPage()),
        Expanded(
          child: isLogin
              ? TabLoginPage(
                  updateIsLogin: updateIsLogin,
                  updateIsSignup: updateIsSignup,
                )
              : isSignup
                  ? TabSignupPage(
                      updateIsLogin: updateIsLogin,
                      updateIsSignup: updateIsSignup,
                    )
                  : TabMainAuthPage(
                      updateIsLogin: updateIsLogin,
                      updateIsSignup: updateIsSignup,
                    ),
        ),
      ],
    );
  }
}

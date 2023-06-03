import 'package:flutter/material.dart';
import 'package:musync/features/authentication/presentation/screens/components/main_auth_page.dart';
import 'package:musync/features/authentication/presentation/screens/login_page.dart';
import 'package:musync/features/authentication/presentation/screens/signup_page.dart';
import 'package:musync/features/home/presentation/components/bottomNav/bottom_nav.dart';
import 'package:musync/features/onBoarding/pages/on_boarding_page.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';
  static const String getStartedRoute = '/welcome';
  static const String onBoardingRoute = '/onBoarding';
  static const forgotPasswordRoute = '/forgotPassword';

  static final Map<String, Widget Function(BuildContext)> loggedinRoute = {
    initialRoute: (context) => const OnBoardingPage(),
    getStartedRoute: (context) => const MainAuthPage(),
    loginRoute: (context) => const LoginPage(),
    signupRoute: (context) => const SignupPage(),
    homeRoute: (context) => BottomNavBar(
          pages: (ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>)['pages'] as List<Widget>,
          selectedIndex: (ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>)['selectedIndex'] as int,
        ),
  };
  static final Map<String, Widget Function(BuildContext)> loggedoutRoute = {
    initialRoute: (context) => const OnBoardingPage(),
    getStartedRoute: (context) => const MainAuthPage(),
    loginRoute: (context) => const LoginPage(),
    signupRoute: (context) => const SignupPage(),
    homeRoute: (context) => BottomNavBar(
          pages: (ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>)['pages'] as List<Widget>,
          selectedIndex: (ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>)['selectedIndex'] as int,
        ),
  };

  static List<Route<dynamic>> generateInitialRoutes({
    required String initialRoute,
    required BuildContext context,
    required bool isFirstTime,
    required bool goHome,
  }) {
    if (initialRoute == '/') {
      if (MediaQuery.of(context).size.width >= 900) {
        return [
          MaterialPageRoute(
            builder: (context) {
              if (!isFirstTime && goHome) {
                return BottomNavBar();
              } else {
                return const Placeholder(); //TabOnboarding();
              }
            },
          ),
        ];
      } else {
        return [
          MaterialPageRoute(
            builder: (context) {
              if (!isFirstTime && goHome) {
                return BottomNavBar();
              } else if (!isFirstTime) {
                return const MainAuthPage();
              } else {
                return const OnBoardingPage();
              }
            },
          ),
        ];
      }
    }
    return [];
  }
}

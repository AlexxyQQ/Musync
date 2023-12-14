import 'package:flutter/material.dart';
import 'package:musync/features/auth/presentation/view/forgot_password_page.dart';
import 'package:musync/features/home/presentation/pages/home_page.dart';

import '../../core/common/no_page_route.dart';
import '../../features/auth/presentation/view/login_page.dart';
import '../../features/auth/presentation/view/signup_page.dart';
import '../../features/auth/presentation/widgets/main_auth_page.dart';
import '../../features/onboarding/presentation/view/on_boarding_page.dart';
import '../../features/splash/presentation/view/splashscreen.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';
  static const String getStartedRoute = '/welcome';
  static const String onBoardingRoute = '/onBoarding';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String nowPlayingRoute = '/nowPlaying';
  static const String settingRoute = '/settings';
  static const String manageAllSongsRoute = '/manageAllSongs';
  static const String manageAllPublicSongsRoute = '/manageAllPublicSongs';

  static final Map<String, Widget Function(BuildContext)> appPageRoutes = {
    // Starters
    initialRoute: (context) => const SplashScreen(),
    onBoardingRoute: (context) => const OnBoardingPage(),
    // Auth
    getStartedRoute: (context) => const MainAuthPage(),
    loginRoute: (context) => const LoginPage(),
    signupRoute: (context) => const SignupPage(),
    forgotPasswordRoute: (context) => const ForgotPasswordPage(),
    // Home
    homeRoute: (context) => const HomePage(),
    // Settings
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // If the named route is not defined, go to the default page
    return MaterialPageRoute(
      builder: (context) => const NoRoutePage(),
    );
  }
}

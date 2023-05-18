import 'package:flutter/material.dart';
import 'package:musync/src/authentication/presentation/components/main_auth_page.dart';
import 'package:musync/src/authentication/presentation/pages/login_page.dart';
import 'package:musync/src/authentication/presentation/pages/signup_page.dart';
import 'package:musync/src/home/presentation/components/bottomNav/bottom_nav.dart';
import 'package:musync/src/music_library/presentation/pages/song_listview.dart';
import 'package:musync/src/onBoarding/presentation/pages/on_boarding_page.dart';

final loggedinRoute = {
  "/": (_) => BottomNavBar(),
  "/welcome": (_) => const MainAuthPage(),
  "/login": (_) => const LoginPage(),
  '/signup': (_) => const SignupPage(),
  "/home": (context) => BottomNavBar(
        pages: (ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>)['pages'] as List<Widget>,
        selectedIndex: (ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>)['selectedIndex'] as int,
      ),
  "/songs": (context) => SongListView(
        songs: ModalRoute.of(context)!.settings.arguments as List,
      ),
  // '/nowPlaying': (_) => const NowPlaying(),
};

final loggedOutRoute = {
  "/": (_) => const OnBoardingPage(),
  "/welcome": (_) => const MainAuthPage(),
  "/login": (_) => const LoginPage(),
  '/signup': (_) => const SignupPage(),
  "/home": (context) => BottomNavBar(
        pages: (ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>)['pages'] as List<Widget>,
        selectedIndex: (ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>)['selectedIndex'] as int,
      ),
  "/songs": (context) => SongListView(
        songs: ModalRoute.of(context)!.settings.arguments as List,
      ),
  // '/nowPlaying': (_) => const NowPlaying(),
};

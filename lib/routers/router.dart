import 'package:flutter/material.dart';
import 'package:musync/ui/home/provider/auth_check.dart';
import 'package:musync/ui/music/pages/music_list_page.dart';
import 'package:musync/ui/on_boarding/pages/on_boarding_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const GetStartedPage(),
      );
    case '/auth_check':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const AuthCheck(),
      );
    case '/music':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const MusicListPage(),
      );
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('404 Page Not Found'),
          ),
        ),
      );
  }
}

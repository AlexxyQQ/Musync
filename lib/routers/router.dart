import 'package:flutter/material.dart';
import 'package:musync/ui/on_boarding/on_boarding_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const GetStartedPage(),
      );
    // case '/home':
    //   return MaterialPageRoute<dynamic>(
    //     builder: (BuildContext context) => const MyHomePage(),
    //   );
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

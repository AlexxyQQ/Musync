import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:musync/routers/router.dart';
import 'package:musync/ui/on_boarding/pages/on_boarding_page.dart';
import 'package:musync/ui/on_boarding/provider/google_sign_in.dart';
import 'package:musync/widgets/bottom_nav.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  var permissionStatus = await Permission.storage.status;
  if (permissionStatus.isDenied) {
    await Permission.storage.request();
  }

  await Firebase.initializeApp();
  runApp(
    MyApp(
      isFirstTime: isFirstTime,
    ),
  );
}

Color ourColor =
    const Color(0XFF171A9E); // color if there is no dynamic color scheme

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      // DynamicColorBuilder is a widget that provides a dynamic color scheme to its child.
      builder: (ColorScheme? lightDynamic, ColorScheme? dark) {
        // lightDynamic is the dynamic color scheme for light mode.
        // dark is the color scheme for dark mode.
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && dark != null) {
          // If both light and dark color schemes are provided, we can use them to create a harmonized color scheme.
          lightColorScheme = lightDynamic.harmonized()..copyWith();
          lightColorScheme = lightColorScheme.copyWith(secondary: ourColor);
          darkColorScheme = dark.harmonized();
        } else {
          // If only one color scheme is provided, we can use it to create a harmonized color scheme.
          lightColorScheme = ColorScheme.fromSeed(seedColor: ourColor);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: ourColor,
            brightness: Brightness.dark,
          );
        }

        return ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Musync',
            theme: ThemeData(
              fontFamily: 'Sans',
              useMaterial3: true, // Enable Material 3
              colorScheme: lightColorScheme,
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorScheme,
            ),
            onGenerateRoute: (settings) => generateRoute(settings),
            home: isFirstTime ? const GetStartedPage() : const BottomNav(),
          ),
        );
      },
    );
  }
}

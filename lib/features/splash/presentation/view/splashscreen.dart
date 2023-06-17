import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/common/loading_screen.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/config/themes/app_theme.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/core/utils/connectivity_check.dart';
import 'package:musync/features/auth/domain/entity/user_entity.dart';
import 'package:musync/features/splash/data/repository/splash_repository.dart';

class MusyncSplash extends StatefulWidget {
  const MusyncSplash({super.key});

  @override
  State<MusyncSplash> createState() => _MusyncSplashState();
}

class _MusyncSplashState extends State<MusyncSplash> {
  // scaffoldKey is used to show snackbar
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // navigatorKey is used to navigate to a page without context
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool isFirstTime = true;
  bool goHome = false;
  late Future<UserEntity?> data;

  Future<UserEntity?> check() async {
    isFirstTime = await GetIt.instance<HiveQueries>().getValue(
      boxName: 'settings',
      key: "isFirstTime",
      defaultValue: true,
    );
    goHome = await GetIt.instance<HiveQueries>().getValue(
      boxName: 'settings',
      key: "goHome",
      defaultValue: false,
    );
    final bool connection = await ConnectivityCheck.connectivity();
    final bool server = await ConnectivityCheck.isServerup();
    if (connection && server) {
      var userData = await SplashRepository().getLoggeduser();
      if (userData.status) {
        setState(() {
          isFirstTime = userData.data['isFirstTime'];
          goHome = userData.data['goHome'];
        });
        kShowSnackBar(
          "Welcome back ${userData.data['user'].username}",
          scaffoldKey: scaffoldKey,
        );
        return userData.data['user'];
      } else {
        setState(() {
          isFirstTime = userData.data['isFirstTime'];
          goHome = userData.data['goHome'];
        });
        kShowSnackBar(
          "Welcome, You are logged in as Guest",
          scaffoldKey: scaffoldKey,
        );
        return null;
      }
    } else if (connection) {
      kShowSnackBar(
        "Server is Down",
        scaffoldKey: scaffoldKey,
      );
      return null;
    } else {
      kShowSnackBar(
        "Server is Down",
        scaffoldKey: scaffoldKey,
      );
      return null;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: "Musync",
              debugShowCheckedModeBanner: false,
              theme: AppTheme.appLightTheme(),
              darkTheme: AppTheme.appDarkTheme(),
              themeMode: ThemeMode.system,
              routes: snapshot.data == null
                  ? Routes.loggedoutRoute
                  : Routes.loggedinRoute,
              onGenerateInitialRoutes: (initialRoute) =>
                  Routes.generateInitialRoutes(
                initialRoute: '/',
                context: context,
                isFirstTime: isFirstTime,
                goHome: goHome,
              ),
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}

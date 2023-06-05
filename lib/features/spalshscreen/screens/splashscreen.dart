import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:musync/core/services/api/api.dart';
import 'package:musync/shared/components/custom_snackbar.dart';
import 'package:musync/shared/components/loading_screen.dart';
import 'package:musync/core/repositories/local_storage_repository.dart';
import 'package:musync/core/models/user_model.dart';
import 'package:musync/core/repositories/user_repositories.dart';
import 'package:musync/routes/routers.dart';
import 'package:musync/shared/themes/app_theme.dart';

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

  late bool isFirstTime = true;
  late bool goHome = false;
  late Future<UserModel?> data;

  /// To check if device is connected to internet using connectivity package
  Future<bool> isConnectedToInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  /// To check if server is up by sending a get request to the server
  Future<bool> isServerUp() async {
    final api = Api();

    try {
      final response = await api.sendRequest.get(
        '/',
      );
      ApiResponse responseApi = ApiResponse.fromResponse(response);
      if (responseApi.success) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// To check if device is connected to internet and server is up
  Future<void> checkConnectivityAndServer() async {
    bool connected = await isConnectedToInternet();
    if (!connected) {
      kShowSnackBar('No internet connection', scaffoldKey: scaffoldKey);
    } else {
      bool serverRunning = await isServerUp();
      if (!serverRunning) {
        kShowSnackBar('Server is down', scaffoldKey: scaffoldKey);
      } else {
        // kShowSnackBar('Server is up', scaffoldKey: scaffoldKey);
      }
    }
  }

  /// To get user data from server
  Future<UserModel?> getUserData() async {
    // gets isFirstTime and goHome from local storage
    isFirstTime = await LocalStorageRepository().getValue(
      boxName: 'settings',
      key: "isFirstTime",
      defaultValue: true,
    );
    goHome = await LocalStorageRepository().getValue(
      boxName: 'settings',
      key: "goHome",
      defaultValue: false,
    );
    final String token = await LocalStorageRepository()
        .getValue(boxName: 'users', key: 'token', defaultValue: '');

    if (token == "") {
      return null;
    } else {
      try {
        final UserModel user = await UserRepositories().getUser(token: token);
        return user;
      } catch (e) {
        kShowSnackBar(e.toString(), scaffoldKey: scaffoldKey);
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    checkConnectivityAndServer();
    data = getUserData();
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

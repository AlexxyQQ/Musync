import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
import 'package:musync/src/authentication/data/providers/authentication_provider.dart';
import 'package:musync/src/authentication/data/providers/user_provider.dart';
import 'package:musync/src/authentication/presentation/components/main_auth_page.dart';
import 'package:musync/src/common/custom_snackbar.dart';
import 'package:musync/src/common/data/models/error_model.dart';
import 'package:musync/src/common/data/repositories/local_storage_repository.dart';
import 'package:musync/src/onBoarding/presentation/pages/on_boarding_page.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/routers.dart';

import 'src/home/presentation/components/bottomNav/bottom_nav.dart';

Future<bool> isConnectedToInternet() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

Future<bool> isServerUp() async {
  return false;
  // ! Uncomment this to check if server is up
  // try {
  //   final res = await http.get(Uri.parse('http://192.168.1.111:3001/')).timeout(
  //         const Duration(seconds: 5),
  //       );
  //   if (res.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // } catch (e) {
  //   return false;
  // }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

ErrorModel? errorModel;

Future<void> checkConnectivityAndServer() async {
  bool connected = await isConnectedToInternet();
  if (!connected) {
    kShowSnackBar('No internet connection', scaffoldKey);
  } else {
    bool serverRunning = await isServerUp();
    if (!serverRunning) {
      kShowSnackBar('Server is down', scaffoldKey);
    } else {
      kShowSnackBar('Server is up', scaffoldKey);
    }
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        body: const HomeWidget(),
      ),
    );
  }
}

class HomeWidget extends ConsumerStatefulWidget {
  const HomeWidget({super.key});

  @override
  ConsumerState<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends ConsumerState<HomeWidget> {
  late Future<ErrorModel> data;

  late bool isFirstTime;
  late bool goHome;
  Future<ErrorModel> getUserData() async {
    if (!await isConnectedToInternet()) {
      errorModel = ErrorModel(error: 'No Internet Connection', data: null);
    } else {
      if (await isServerUp()) {
        errorModel = await ref.read(authenticationProvider).getUserData();
        if (errorModel != null && errorModel!.data != null) {
          ref.read(userProvider.notifier).update((state) => errorModel!.data);
        }
      } else {
        errorModel = ErrorModel(error: 'Server is down', data: null);
      }
    }
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

    return errorModel!;
  }

  @override
  void initState() {
    super.initState();
    data = getUserData();
    checkConnectivityAndServer();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return FutureBuilder<ErrorModel>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: "Musync",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Sans',
              useMaterial3: true, // Enable Material 3
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: blackColor,
                    displayColor: blackColor,
                  ),
            ),
            darkTheme: ThemeData(
              fontFamily: 'Sans',
              useMaterial3: true, // Enable Material 3
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: whiteColor,
                    displayColor: whiteColor,
                  ),
            ),
            routes: (user != null && user.token.isNotEmpty)
                ? loggedinRoute
                : loggedOutRoute,
            navigatorKey: navigatorKey,
            onGenerateInitialRoutes: (initialRoute) {
              if (initialRoute == '/') {
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
              return [];
            },
          );
        } else {
          return Container(
            color: whiteColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

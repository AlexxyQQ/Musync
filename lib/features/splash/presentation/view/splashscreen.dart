import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/common/loading_screen.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/config/themes/app_theme.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/splash/presentation/viewmodel/splash_view_model.dart';

class MusyncSplash extends StatefulWidget {
  const MusyncSplash({super.key});

  @override
  State<MusyncSplash> createState() => _MusyncSplashState();
}

class _MusyncSplashState extends State<MusyncSplash> {
  @override
  void initState() {
    BlocProvider.of<SplashViewModel>(context).initialLogin();
    super.initState();
  }
  // // scaffoldKey is used to show snackbar
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // // navigatorKey is used to navigate to a page without context
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // bool isFirstTime = true;
  // bool goHome = false;
  // late Future<UserEntity?> data;

  // Future<UserEntity?> check() async {
  //   var authProvider = BlocProvider.of<AuthViewModel>(context);

  //   final bool connection = await ConnectivityCheck.connectivity();
  //   final bool server = await ConnectivityCheck.isServerup();
  //   isFirstTime = await GetIt.instance<HiveQueries>().getValue(
  //     boxName: 'settings',
  //     key: "isFirstTime",
  //     defaultValue: true,
  //   );
  //   goHome = await GetIt.instance<HiveQueries>().getValue(
  //     boxName: 'settings',
  //     key: "goHome",
  //     defaultValue: false,
  //   );
  //   if (connection && server) {
  //     var userData = await authProvider.initialLogin();

  //     if (userData.isRight()) {
  //       setState(() {
  //         isFirstTime = isFirstTime;
  //         goHome = goHome;
  //       });
  //       kShowSnackBar(
  //         "Welcome back",
  //         scaffoldKey: scaffoldKey,
  //       );
  //       return userData.fold((l) => null, (r) => r);
  //     } else {
  //       setState(() {
  //         isFirstTime = isFirstTime;
  //         goHome = goHome;
  //       });

  //       return null;
  //     }
  //   } else if (connection) {
  //     kShowSnackBar(
  //       "Server is Down",
  //       scaffoldKey: scaffoldKey,
  //     );
  //     return null;
  //   } else {
  //     kShowSnackBar(
  //       "Server is Down",
  //       scaffoldKey: scaffoldKey,
  //     );
  //     return null;
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   data = check();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashViewModel, AuthState>(
        builder: (blocContext, state) {
          if (state.isLoading) {
            return const LoadingScreen();
          } else {
            if (state.isError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                kShowSnackBar(
                  state.authError!,
                  context: blocContext,
                );
              });
            }
            return SplashMaterial(
              state: state,
              blocContext: blocContext,
            );
          }
        },
      ),
    );
  }
}

class SplashMaterial extends StatelessWidget {
  final AuthState state;
  final BuildContext blocContext;
  const SplashMaterial({
    super.key,
    required this.state,
    required this.blocContext,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Musync",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appLightTheme(),
      darkTheme: AppTheme.appDarkTheme(),
      themeMode: ThemeMode.system,
      routes: state.loggedUser == null
          ? AppRoutes.loggedoutRoute
          : AppRoutes.loggedinRoute,
      onGenerateInitialRoutes: (initialRoute) =>
          AppRoutes.generateInitialRoutes(
        initialRoute: '/',
        context: blocContext,
        isFirstTime: state.isFirstTime,
        goHome: state.goHome,
      ),
    );
  }
}

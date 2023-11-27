import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/config/themes/app_theme.dart';
import 'package:musync/core/bloc/bloc_providers.dart';
import 'package:musync/core/utils/device_info.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late String model = 'Default';

  Future<void> deviceConfig() async {
    final device = await GetDeviceInfo.deviceInfoPlugin.androidInfo;
    model = device.model;
  }

  @override
  void initState() {
    super.initState();
    deviceConfig();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProvidersList.blocList,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: "Musync",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appLightTheme(),
            darkTheme: AppTheme.appDarkTheme(),
            themeMode: ThemeMode.system,
            routes: AppRoutes.appPageRoutes,
          );
        },
      ),
    );
  }
}

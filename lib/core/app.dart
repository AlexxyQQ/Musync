import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/config/themes/app_theme.dart';
import 'package:musync/core/bloc/bloc_providers.dart';
import 'package:musync/core/utils/device_info.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/features/socket/presentation/state/state.dart';
import 'package:musync/features/socket/presentation/view_model/socket_view_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

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
      child: BlocBuilder<AuthViewModel, AuthState>(
        builder: (authContext, authState) {
          return BlocBuilder<SocketCubit, SocketState>(
            builder: (socketContext, socketState) {
              socketContext.read<SocketCubit>().initSocket(
                    loggedUser: authState.loggedUser,
                    model: model,
                  );

              socketContext.read<SocketCubit>().onConnect();
              socketContext
                  .read<SocketCubit>()
                  .onRecievedShare(context: socketContext);
              return StreamBuilder<io.Socket>(
                stream: socketContext.read<SocketCubit>().socketStream,
                builder: (context, snapshot) {
                  return ScreenUtilInit(
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
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

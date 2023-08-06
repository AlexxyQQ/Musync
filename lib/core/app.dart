import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/config/themes/app_theme.dart';
import 'package:musync/core/utils/device_info.dart';
import 'package:musync/features/auth/domain/use_case/auth_use_case.dart';
import 'package:musync/features/auth/presentation/state/authentication_state.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/features/home/domain/use_case/music_query_use_case.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/nowplaying/domain/use_case/now_playing_use_case.dart';
import 'package:musync/features/nowplaying/presentation/view_model/audio_service_handeler.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:musync/features/socket/presentation/state/state.dart';
import 'package:musync/features/socket/presentation/view_model/socket_view_model.dart';
import 'package:musync/features/splash/domain/use_case/splash_use_case.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class App extends StatefulWidget {
  final MyAudioHandler audioHandler;
  const App({super.key, required this.audioHandler});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late String model = 'ccc';

  Future<void> sothing() async {
    final device = await GetDeviceInfo.deviceInfoPlugin.androidInfo;
    model = device.model;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sothing();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthViewModel>(
          create: (context) => AuthViewModel(
            authUseCase: GetIt.instance<AuthUseCase>(),
            splashUseCase: GetIt.instance<SplashUseCase>(),
          ),
        ),
        BlocProvider<MusicQueryViewModel>(
          create: (context) =>
              MusicQueryViewModel(GetIt.instance<MusicQueryUseCase>()),
        ),
        BlocProvider<NowPlayingViewModel>(
          create: (context) => NowPlayingViewModel(
            GetIt.instance<NowPlayingUseCase>(),
            widget.audioHandler,
          ),
        ),
        BlocProvider<SocketCubit>(
          create: (context) => SocketCubit(
            GetIt.instance<NowPlayingUseCase>(),
            // NowPlayingViewModel(GetIt.instance<NowPlayingUseCase>()),
          ),
        ),
      ],
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
                  return MaterialApp(
                    title: "Musync",
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.appLightTheme(),
                    darkTheme: AppTheme.appDarkTheme(),
                    themeMode: ThemeMode.system,
                    routes: authState.loggedUser == null
                        ? AppRoutes.loggedoutRoute
                        : AppRoutes.loggedinRoute,
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

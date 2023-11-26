import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:musync/features/socket/presentation/view_model/socket_view_model.dart';

import '../../injection/app_injection_container.dart';

class BlocProvidersList {
  static final blocList = [
    BlocProvider<AuthViewModel>(
      create: (context) => AuthViewModel(
        deleteUserUseCase: get(),
        googleLoginUseCase: get(),
        loginUseCase: get(),
        logoutUseCase: get(),
        signupUseCase: get(),
        splashUseCase: get(),
        uploadProfilePicUseCase: get(),
      ),
    ),
    BlocProvider<MusicQueryViewModel>(
      create: (context) => MusicQueryViewModel(get()),
    ),
    BlocProvider<NowPlayingViewModel>(
      create: (context) => NowPlayingViewModel(
        get(),
      ),
    ),
    BlocProvider<SocketCubit>(
      create: (context) => SocketCubit(
        get(),
      ),
    ),
  ];
}

import 'package:musync/features/now_playing/presentation/cubit/now_playing_cubit.dart';

import '../../../injection/app_injection_container.dart';

class NowPlayingInjectionContainer {
  void register() {
    // Cubit
    get.registerFactory(
      () => NowPlayingCubit(
        getLyricsUseCase: get(),
      ),
    );
  }
}

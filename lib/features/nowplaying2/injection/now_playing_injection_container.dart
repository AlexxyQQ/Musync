import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/features/nowplaying2/data/data_source/now_playing_local_data_source.dart';
import 'package:musync/features/nowplaying2/data/repository/now_playing_repositories.dart';
import 'package:musync/features/nowplaying2/domain/use_case/now_playing_use_case.dart';

class NowPlayingInjectionContainer {
  var get = GetIt.instance;

  void register() {
    get.registerLazySingleton(
      () => NowPlayingLocalDataSource(get<AudioPlayer>()),
    );
    get.registerLazySingleton(
      () => NowPlayignRepositiryImpl(
        get<NowPlayingLocalDataSource>(),
      ),
    );
    get.registerLazySingleton(
      () => NowPlayingUseCase(
        get<NowPlayignRepositiryImpl>(),
      ),
    );
  }
}

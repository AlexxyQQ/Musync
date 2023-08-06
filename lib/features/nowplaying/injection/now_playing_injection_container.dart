import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/features/nowplaying/data/data_source/now_playing_local_data_source.dart';
import 'package:musync/features/nowplaying/data/data_source/now_playing_remote_data_source.dart';
import 'package:musync/features/nowplaying/data/repository/now_playing_repositories.dart';
import 'package:musync/features/nowplaying/domain/use_case/now_playing_use_case.dart';

class NowPlayingInjectionContainer {
  var get = GetIt.instance;

  void register() {
    get.registerLazySingleton(
      () => NowPlayingLocalDataSource(get<AudioPlayer>()),
    );
    get.registerLazySingleton(
      () => NowPlayingRemoteDataSource(get<AudioPlayer>()),
    );
    get.registerLazySingleton(
      () => NowPlayignRepositiryImpl(
        get<NowPlayingLocalDataSource>(),
        get<NowPlayingRemoteDataSource>(),
      ),
    );
    get.registerLazySingleton(
      () => NowPlayingUseCase(
        get<NowPlayignRepositiryImpl>(),
      ),
    );
  }
}

import 'package:just_audio/just_audio.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit()
      : super(
          NowPlayingState.initial(),
        );

  void setSongs({
    required List<SongEntity> songs,
    required SongEntity song,
    required BuildContext context,
  }) async {
    emit(
      state.copyWith(
        currentIndex: songs.indexOf(song),
      ),
    );
    final nav = Navigator.of(context);
    await get<AudioPlayer>().setAudioSource(
      ConcatenatingAudioSource(
        children: songs
            .map(
              (song) => AudioSource.uri(
                Uri.file(song.data),
                tag: song,
              ),
            )
            .toList(),
      ),
      initialIndex: state.currentIndex,
    );
    get<AudioPlayer>().play();
    emit(
      state.copyWith(
        currentSong: song,
        isPlaying: true,
        queue: songs,
      ),
    );
    if (state.queue!.isEmpty) {
      nav.pushNamed(AppRoutes.nowPlayingRoute);
    }
  }

  void play() {
    get<AudioPlayer>().play();
    emit(
      state.copyWith(
        isPlaying: true,
      ),
    );
  }

  void pause() {
    get<AudioPlayer>().pause();
    emit(
      state.copyWith(
        isPlaying: false,
      ),
    );
  }

  void stop() {
    get<AudioPlayer>().stop();
    emit(
      state.copyWith(
        isPlaying: false,
      ),
    );
  }

  void next() async {
    await get<AudioPlayer>().seekToNext();
    emit(
      state.copyWith(
        currentSong: state.queue![get<AudioPlayer>().currentIndex ?? 0],
        currentIndex: get<AudioPlayer>().currentIndex ?? 0,
      ),
    );
  }

  void shuffle() async {
    await get<AudioPlayer>().shuffle();
    emit(
      state.copyWith(
        currentSong: state.queue![get<AudioPlayer>().currentIndex ?? 0],
        currentIndex: get<AudioPlayer>().currentIndex ?? 0,
        queue: state.queue,
      ),
    );
  }

  void clearQueue() async {
    await get<AudioPlayer>().stop();
    emit(
      state.copyWith(
        currentSong: null,
        currentIndex: 0,
        isPlaying: false,
        queue: [],
      ),
    );
  }
}

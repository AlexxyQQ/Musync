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
        audioPlayer: get<AudioPlayer>(),
      ),
    );
    final nav = Navigator.of(context);
    await state.audioPlayer!.setAudioSource(
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
    state.audioPlayer!.play();
    if (!state.isPlaying) {
      nav.pushNamed(AppRoutes.nowPlayingRoute);
    }
    emit(
      state.copyWith(
        currentSong: song,
        isPlaying: true,
        queue: songs,
      ),
    );
  }

  void play() {
    state.audioPlayer!.play();
    emit(
      state.copyWith(
        isPlaying: true,
      ),
    );
  }

  void pause() {
    state.audioPlayer!.pause();
    emit(
      state.copyWith(
        isPlaying: false,
      ),
    );
  }

  void stop() {
    state.audioPlayer!.stop();
    emit(
      state.copyWith(
        isPlaying: false,
      ),
    );
  }

  void next() async {
    await state.audioPlayer!.seekToNext();
    emit(
      state.copyWith(
        currentSong: state.queue![state.audioPlayer!.currentIndex ?? 0],
        currentIndex: state.audioPlayer!.currentIndex ?? 0,
      ),
    );
  }

  void shuffle() async {
    // if already shuffled, unshuffle arrange in order of title
    if (state.isShuffle) {
      state.queue!.sort((a, b) => a.title.compareTo(b.title));
      await state.audioPlayer!.setAudioSource(
        ConcatenatingAudioSource(
          children: state.queue!
              .map(
                (song) => AudioSource.uri(
                  Uri.file(song.data),
                  tag: song,
                ),
              )
              .toList(),
        ),
        initialIndex: state.queue!.indexOf(state.currentSong!),
      );
      emit(
        state.copyWith(
          queue: state.queue,
          isShuffle: false,
        ),
      );
    } else {
      state.queue!.shuffle();
      await state.audioPlayer!.setAudioSource(
        ConcatenatingAudioSource(
          children: state.queue!
              .map(
                (song) => AudioSource.uri(
                  Uri.file(song.data),
                  tag: song,
                ),
              )
              .toList(),
        ),
        initialIndex: state.queue!.indexOf(state.currentSong!),
      );
      emit(
        state.copyWith(
          queue: state.queue,
          isShuffle: true,
        ),
      );
    }
  }

  void clearQueue() async {
    await state.audioPlayer!.stop();
    emit(
      state.copyWith(
        currentSong: null,
        currentIndex: 0,
        isPlaying: false,
        queue: [],
      ),
    );
  }

  void previous() {
    state.audioPlayer!.seekToPrevious();
    emit(
      state.copyWith(
        currentSong: state.queue![state.audioPlayer!.currentIndex ?? 0],
        currentIndex: state.audioPlayer!.currentIndex ?? 0,
      ),
    );
  }

  void repeat() {
    // Repeat single song
    if (state.isRepeat) {
      state.audioPlayer!.setLoopMode(LoopMode.off);
      emit(
        state.copyWith(
          isRepeat: false,
        ),
      );
    } else {
      state.audioPlayer!.setLoopMode(LoopMode.one);
      emit(
        state.copyWith(
          isRepeat: true,
        ),
      );
    }
  }
}

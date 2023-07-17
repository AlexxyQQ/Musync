import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/nowplaying/domain/use_case/now_playing_use_case.dart';
import 'package:musync/features/nowplaying/presentation/state/now_playing_state.dart';

class NowPlayingViewModel extends Cubit<NowPlayingState> {
  final NowPlayingUseCase nowPlayingUseCase;
  NowPlayingViewModel(
    this.nowPlayingUseCase,
  ) : super(NowPlayingState.initial()) {
    init();
  }

  // Init
  Future<void> init() async {
    final isShuffle = await GetIt.instance
        .get<HiveQueries>()
        .getValue(boxName: 'settings', key: 'shuffle', defaultValue: false);

    emit(
      state.copyWith(
        isShuffle: isShuffle,
      ),
    );
  }

  // PlayAll
  Future<void> playAll({
    required List<SongEntity> songs,
    required int index,
  }) async {
    emit(state.copyWith(isLoading: true));
    await nowPlayingUseCase.playAll(
      songs: songs,
      index: index,
    );
    emit(
      state.copyWith(
        isLoading: false,
        isPlaying: true,
        isPaused: false,
        isStopped: false,
        currentSong: songs[index],
        queue: songs,
        currentIndex: index,
      ),
    );
  }

  // Play
  Future<void> play() async {
    emit(
      state.copyWith(
        isLoading: true,
        isPlaying: true,
        isPaused: false,
        isStopped: false,
      ),
    );
    await state.audioPlayer.play();
    emit(
      state.copyWith(
        isLoading: false,
        isPlaying: true,
        isPaused: false,
        isStopped: false,
      ),
    );
  }

  // Pause
  Future<void> pause() async {
    await state.audioPlayer.pause();
    emit(
      state.copyWith(
        isPlaying: false,
        isStopped: false,
        isPaused: true,
      ),
    );
  }

  // Stop
  Future<void> stop() async {
    await state.audioPlayer.stop();
    emit(
      state.copyWith(
        isPlaying: false,
        isPaused: false,
        isStopped: true,
      ),
    );
  }

  // Shuffle
  Future<void> shuffle() async {
    GetIt.instance
        .get<HiveQueries>()
        .setValue(boxName: 'settings', key: 'shuffle', value: true);
    emit(
      state.copyWith(
        isShuffle: !state.isShuffle,
        queue: state.queue..shuffle(),
      ),
    );
  }

  // UnShuffle
  Future<void> unShuffle() async {
    GetIt.instance
        .get<HiveQueries>()
        .setValue(boxName: 'settings', key: 'shuffle', value: false);
    emit(
      state.copyWith(
        isShuffle: !state.isShuffle,
        queue: state.queue
          ..sort(
            (a, b) => a.title.compareTo(b.title),
          ),
      ),
    );
  }

  // Next
  Future<void> next() async {
    if (state.queue.length > state.currentIndex + 1 && !state.isRepeatOne) {
      await state.audioPlayer.seek(Duration.zero);
      await state.audioPlayer.seekToNext();

      emit(
        state.copyWith(
          isPlaying: true,
          isPaused: false,
          isStopped: false,
          currentSong:
              state.queue[state.audioPlayer.sequenceState!.currentIndex],
          currentIndex: state.audioPlayer.sequenceState!.currentIndex,
          queue: state.audioPlayer.sequenceState!.sequence
              .map((e) => e.tag as SongEntity)
              .toList(),
        ),
      );
    } else {
      await state.audioPlayer.seek(Duration.zero);
      emit(
        state.copyWith(
          isPlaying: true,
          isPaused: false,
          isStopped: false,
        ),
      );
    }
  }

  // Previous
  Future<void> previous() async {
    if (state.currentIndex - 1 >= 0 && !state.isRepeatOne) {
      await state.audioPlayer.seek(Duration.zero);
      await state.audioPlayer.seekToPrevious();
      emit(
        state.copyWith(
          isPlaying: true,
          isPaused: false,
          isStopped: false,
          currentSong:
              state.queue[state.audioPlayer.sequenceState!.currentIndex],
          currentIndex: state.audioPlayer.sequenceState!.currentIndex,
          queue: state.audioPlayer.sequenceState!.sequence
              .map((e) => e.tag as SongEntity)
              .toList(),
        ),
      );
    } else {
      await state.audioPlayer.seek(Duration.zero);
      emit(
        state.copyWith(
          isPlaying: true,
          isPaused: false,
          isStopped: false,
        ),
      );
    }
  }

  // RepeatOne
  Future<void> repeatOne() async {
    emit(state.copyWith(isRepeatAll: false));
    await state.audioPlayer.setLoopMode(LoopMode.one);
    emit(
      state.copyWith(
        isRepeatAll: false,
        isRepaeatOne: true,
      ),
    );
  }

  // RepeatAll
  Future<void> repeatAll() async {
    emit(state.copyWith(isRepaeatOne: false));
    await state.audioPlayer.setLoopMode(LoopMode.all);
    emit(
      state.copyWith(
        isRepeatAll: true,
        isRepaeatOne: false,
      ),
    );
  }

  // RepeatOff
  Future<void> repeatOff() async {
    await state.audioPlayer.setLoopMode(LoopMode.off);
    emit(
      state.copyWith(
        isRepeatAll: false,
        isRepaeatOne: false,
      ),
    );
  }

  Future<void> clearQueue() async {
    emit(
      state.copyWith(
        isPlaying: false,
        isPaused: false,
        isStopped: true,
        // remove all songs except the current song
        currentSong: state.queue[state.audioPlayer.sequenceState!.currentIndex],
        currentIndex: 0,
        queue: [state.queue[state.audioPlayer.sequenceState!.currentIndex]],
      ),
    );
  }
}

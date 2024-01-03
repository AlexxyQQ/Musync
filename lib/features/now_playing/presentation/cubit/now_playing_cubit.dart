import 'dart:developer';

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
    await state.audioPlayer!.shuffle();
    emit(
      state.copyWith(
        currentSong: state.queue![state.audioPlayer!.currentIndex ?? 0],
        currentIndex: state.audioPlayer!.currentIndex ?? 0,
        queue: state.queue,
      ),
    );
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
}

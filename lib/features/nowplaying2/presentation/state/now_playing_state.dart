import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class NowPlayingState {
  final AudioPlayer audioPlayer;
  final bool isLoading;
  final bool isPlaying;
  final bool isPaused;
  final bool isStopped;
  final String? errorMessage;

  final SongEntity currentSong;
  final List<SongEntity> queue;
  final int currentIndex;
  final bool isShuffle;
  final bool isRepeatOne;
  final bool isRepeatAll;
  final Duration position;

  NowPlayingState({
    required this.audioPlayer,
    required this.isLoading,
    required this.isPlaying,
    this.errorMessage,
    required this.currentSong,
    required this.queue,
    required this.currentIndex,
    required this.isShuffle,
    required this.isRepeatOne,
    required this.isRepeatAll,
    required this.position,
    required this.isPaused,
    required this.isStopped,
  });

  factory NowPlayingState.initial() {
    return NowPlayingState(
      audioPlayer: GetIt.instance.get<AudioPlayer>(),
      isLoading: false,
      isPlaying: false,
      errorMessage: null,
      currentSong: const SongEntity(
        id: 0,
        data: '',
        uri: '',
        displayName: '',
        displayNameWOExt: '',
        size: 0,
        albumArt: '',
        title: '',
        fileExtension: '',
        isRingtone: false,
      ),
      queue: [],
      isPaused: false,
      isStopped: true,
      currentIndex: 0,
      isShuffle: false,
      isRepeatOne: false,
      isRepeatAll: false,
      position: Duration.zero,
    );
  }

  NowPlayingState copyWith({
    AudioPlayer? audioPlayer,
    bool? isLoading,
    bool? isPlaying,
    String? errorMessage,
    SongEntity? currentSong,
    List<SongEntity>? queue,
    int? currentIndex,
    bool? isShuffle,
    bool? isRepaeatOne,
    bool? isRepeatAll,
    Duration? position,
    bool? isPaused,
    bool? isStopped,
  }) {
    return NowPlayingState(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isLoading: isLoading ?? this.isLoading,
      isPlaying: isPlaying ?? this.isPlaying,
      errorMessage: errorMessage ?? this.errorMessage,
      currentSong: currentSong ?? this.currentSong,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isShuffle: isShuffle ?? this.isShuffle,
      isRepeatOne: isRepaeatOne ?? this.isRepeatOne,
      isRepeatAll: isRepeatAll ?? this.isRepeatAll,
      position: position ?? this.position,
      isPaused: isPaused ?? this.isPaused,
      isStopped: isStopped ?? this.isStopped,
    );
  }

  @override
  String toString() {
    return 'NowPlayingState(audioPlayer: $audioPlayer, isLoading: $isLoading, isPlaying: $isPlaying, isPaused: $isPaused, isStopped: $isStopped, errorMessage: $errorMessage, currentIndex: $currentIndex, isShuffle: $isShuffle, isRepaeatOne: $isRepeatOne, isRepeatAll: $isRepeatAll, position: $position)';
  }
}

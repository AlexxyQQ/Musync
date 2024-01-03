import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class NowPlayingState {
  final bool isLoading;
  final bool isSuccess;
  final AppErrorHandler? error;
  final SongEntity? currentSong;
  final List<SongEntity>? queue;
  final int currentIndex;

  // Audio Control
  final bool isPlaying;
  final bool isShuffle;
  final bool isRepeat;

  NowPlayingState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.currentSong,
    this.queue,
    required this.currentIndex,
    required this.isPlaying,
    required this.isShuffle,
    required this.isRepeat,
  });

  factory NowPlayingState.initial() {
    return NowPlayingState(
      isLoading: false,
      isSuccess: false,
      error: null,
      currentSong: null,
      isPlaying: false,
      queue: [],
      isShuffle: false,
      isRepeat: false,
      currentIndex: 0,
    );
  }

  NowPlayingState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AppErrorHandler? error,
    SongEntity? currentSong,
    List<SongEntity>? queue,
    int? currentIndex,
    bool? isPlaying,
    bool? isShuffle,
    bool? isRepeat,
  }) {
    return NowPlayingState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      currentSong: currentSong ?? this.currentSong,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      isShuffle: isShuffle ?? this.isShuffle,
      isRepeat: isRepeat ?? this.isRepeat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
      'isSuccess': isSuccess,
      'error': error?.toMap(),
      'currentSong': currentSong?.toMap(),
      'queue': queue?.map((x) => x?.toMap()).toList(),
      'currentIndex': currentIndex,
      'isPlaying': isPlaying,
      'isShuffle': isShuffle,
      'isRepeat': isRepeat,
    };
  }

  factory NowPlayingState.fromMap(Map<String, dynamic> map) {
    return NowPlayingState(
      isLoading: map['isLoading'] as bool,
      isSuccess: map['isSuccess'] as bool,
      error: map['error'] != null
          ? AppErrorHandler.fromMap(map['error'] as Map<String, dynamic>)
          : null,
      currentSong: map['currentSong'] != null
          ? SongEntity.fromMap(map['currentSong'] as Map<String, dynamic>)
          : null,
      queue: map['queue'] != null
          ? List<SongEntity>.from(
              (map['queue'] as List<int>).map<SongEntity?>(
                (x) => SongEntity.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      currentIndex: map['currentIndex'] as int,
      isPlaying: map['isPlaying'] as bool,
      isShuffle: map['isShuffle'] as bool,
      isRepeat: map['isRepeat'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NowPlayingState.fromJson(String source) =>
      NowPlayingState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NowPlayingState(isLoading: $isLoading, isSuccess: $isSuccess, error: $error, currentSong: $currentSong, queue: $queue, currentIndex: $currentIndex, isPlaying: $isPlaying, isShuffle: $isShuffle, isRepeat: $isRepeat)';
  }

  @override
  bool operator ==(covariant NowPlayingState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.error == error &&
        other.currentSong == currentSong &&
        listEquals(other.queue, queue) &&
        other.currentIndex == currentIndex &&
        other.isPlaying == isPlaying &&
        other.isShuffle == isShuffle &&
        other.isRepeat == isRepeat;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        error.hashCode ^
        currentSong.hashCode ^
        queue.hashCode ^
        currentIndex.hashCode ^
        isPlaying.hashCode ^
        isShuffle.hashCode ^
        isRepeat.hashCode;
  }
}

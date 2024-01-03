// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class NowPlayingState {
  final bool isLoading;
  final bool isSuccess;
  final AppErrorHandler? error;
  final SongEntity? currentSong;
  final List<SongEntity>? queue;
  final int currentIndex;
  final AudioPlayer? audioPlayer;

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
    required this.audioPlayer,
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
      audioPlayer: null,
    );
  }

  NowPlayingState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AppErrorHandler? error,
    SongEntity? currentSong,
    List<SongEntity>? queue,
    int? currentIndex,
    AudioPlayer? audioPlayer,
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
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isPlaying: isPlaying ?? this.isPlaying,
      isShuffle: isShuffle ?? this.isShuffle,
      isRepeat: isRepeat ?? this.isRepeat,
    );
  }

  @override
  String toString() {
    return 'NowPlayingState(isLoading: $isLoading, isSuccess: $isSuccess, error: $error, currentSong: $currentSong, queue: $queue, currentIndex: $currentIndex, audioPlayer: $audioPlayer, isPlaying: $isPlaying, isShuffle: $isShuffle, isRepeat: $isRepeat)';
  }

  @override
  bool operator ==(covariant NowPlayingState other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.error == error &&
        other.currentSong == currentSong &&
        listEquals(other.queue, queue) &&
        other.currentIndex == currentIndex &&
        other.audioPlayer == audioPlayer &&
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
        audioPlayer.hashCode ^
        isPlaying.hashCode ^
        isShuffle.hashCode ^
        isRepeat.hashCode;
  }
}

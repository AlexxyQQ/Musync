import 'dart:convert';

import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class NowPlayingState {
  final bool isLoading;
  final bool isSuccess;
  final AppErrorHandler? error;
  final SongEntity? currentSong;
  NowPlayingState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.currentSong,
  });

  factory NowPlayingState.initial() {
    return NowPlayingState(
      isLoading: false,
      isSuccess: false,
      error: null,
      currentSong: null,
    );
  }

  NowPlayingState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AppErrorHandler? error,
    SongEntity? currentSong,
  }) {
    return NowPlayingState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      currentSong: currentSong ?? this.currentSong,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
      'isSuccess': isSuccess,
      'error': error?.toMap(),
      'currentSong': currentSong?.toMap(),
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
    );
  }

  String toJson() => json.encode(toMap());

  factory NowPlayingState.fromJson(String source) =>
      NowPlayingState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NowPlayingState(isLoading: $isLoading, isSuccess: $isSuccess, error: $error, currentSong: $currentSong)';
  }

  @override
  bool operator ==(covariant NowPlayingState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.error == error &&
        other.currentSong == currentSong;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        error.hashCode ^
        currentSong.hashCode;
  }
}

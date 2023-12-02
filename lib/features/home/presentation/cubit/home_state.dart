import 'package:flutter/foundation.dart';

import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class HomeState {
  final bool isLoading;
  final AppErrorHandler? error;
  final List<SongEntity>? songs;
  final bool isSuccess;
  final int count;
  HomeState({
    required this.isLoading,
    required this.error,
    this.songs,
    required this.isSuccess,
    required this.count,
  });

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      error: null,
      isSuccess: false,
      count: 0,
      songs: null,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    AppErrorHandler? error,
    List<SongEntity>? songs,
    bool? isSuccess,
    int? count,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      songs: songs ?? this.songs,
      isSuccess: isSuccess ?? this.isSuccess,
      count: count ?? this.count,
    );
  }

  @override
  String toString() {
    return 'HomeState(isLoading: $isLoading, error: $error, songs: $songs, isSuccess: $isSuccess, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState &&
        other.isLoading == isLoading &&
        other.error == error &&
        listEquals(other.songs, songs) &&
        other.isSuccess == isSuccess &&
        other.count == count;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        error.hashCode ^
        songs.hashCode ^
        isSuccess.hashCode ^
        count.hashCode;
  }
}

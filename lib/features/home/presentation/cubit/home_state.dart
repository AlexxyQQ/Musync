// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/artist_entity.dart';
import 'package:musync/features/home/domain/entity/folder_entity.dart';
import 'package:musync/features/home/domain/entity/recently_played_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class HomeState {
  final bool isLoading;
  final AppErrorHandler? error;
  final List<SongEntity> songs;
  final List<AlbumEntity> albums;
  final List<ArtistEntity> artists;
  final List<FolderEntity> folders;
  final RecentlyPlayedEntity? recentlyPlayed;
  final bool isSuccess;
  final int count;
  HomeState({
    required this.isLoading,
    required this.error,
    required this.songs,
    required this.albums,
    required this.artists,
    required this.folders,
    this.recentlyPlayed,
    required this.isSuccess,
    required this.count,
  });

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      error: null,
      isSuccess: false,
      count: 0,
      songs: [],
      albums: [],
      artists: [],
      folders: [],
    );
  }

  HomeState copyWith({
    bool? isLoading,
    AppErrorHandler? error,
    List<SongEntity>? songs,
    List<AlbumEntity>? albums,
    List<ArtistEntity>? artists,
    List<FolderEntity>? folders,
    RecentlyPlayedEntity? recentlyPlayed,
    bool? isSuccess,
    int? count,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      songs: songs ?? this.songs,
      albums: albums ?? this.albums,
      artists: artists ?? this.artists,
      folders: folders ?? this.folders,
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      isSuccess: isSuccess ?? this.isSuccess,
      count: count ?? this.count,
    );
  }

  @override
  String toString() {
    return 'HomeState(isLoading: $isLoading, error: $error, songs: $songs, albums: $albums, artists: $artists, folders: $folders, recentlyPlayed: $recentlyPlayed, isSuccess: $isSuccess, count: $count)';
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        other.error == error &&
        listEquals(other.songs, songs) &&
        listEquals(other.albums, albums) &&
        listEquals(other.artists, artists) &&
        listEquals(other.folders, folders) &&
        other.recentlyPlayed == recentlyPlayed &&
        other.isSuccess == isSuccess &&
        other.count == count;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        error.hashCode ^
        songs.hashCode ^
        albums.hashCode ^
        artists.hashCode ^
        folders.hashCode ^
        recentlyPlayed.hashCode ^
        isSuccess.hashCode ^
        count.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoading': isLoading,
      'error': error?.toMap(),
      'songs': songs.map((x) => x.toMap()).toList(),
      'albums': albums.map((x) => x.toMap()).toList(),
      'artists': artists.map((x) => x.toMap()).toList(),
      'folders': folders.map((x) => x.toMap()).toList(),
      'recentlyPlayed': recentlyPlayed?.toMap(),
      'isSuccess': isSuccess,
      'count': count,
    };
  }

  factory HomeState.fromMap(Map<String, dynamic> map) {
    return HomeState(
      isLoading: map['isLoading'] as bool,
      error: map['error'] != null
          ? AppErrorHandler.fromMap(map['error'] as Map<String, dynamic>)
          : null,
      songs: List<SongEntity>.from(
        (map['songs'] as List<int>).map<SongEntity>(
          (x) => SongEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      albums: List<AlbumEntity>.from(
        (map['albums'] as List<int>).map<AlbumEntity>(
          (x) => AlbumEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      artists: List<ArtistEntity>.from(
        (map['artists'] as List<int>).map<ArtistEntity>(
          (x) => ArtistEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      folders: List<FolderEntity>.from(
        (map['folders'] as List<int>).map<FolderEntity>(
          (x) => FolderEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      recentlyPlayed: map['recentlyPlayed'] != null
          ? RecentlyPlayedEntity.fromMap(
              map['recentlyPlayed'] as Map<String, dynamic>)
          : null,
      isSuccess: map['isSuccess'] as bool,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeState.fromJson(String source) =>
      HomeState.fromMap(json.decode(source) as Map<String, dynamic>);
}

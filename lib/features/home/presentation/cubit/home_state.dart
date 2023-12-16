import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/artist_entity.dart';
import 'package:musync/features/home/domain/entity/folder_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class HomeState {
  final bool isLoading;
  final AppErrorHandler? error;
  final List<SongEntity>? songs;
  final List<AlbumEntity>? albums;
  final List<ArtistEntity>? artists;
  final List<FolderEntity>? folders;
  final bool isSuccess;
  final int count;
  HomeState({
    required this.isLoading,
    required this.error,
    this.songs,
    required this.albums,
    required this.artists,
    required this.folders,
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
      albums: null,
      artists: null,
      folders: null,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    AppErrorHandler? error,
    List<SongEntity>? songs,
    List<AlbumEntity>? albums,
    List<ArtistEntity>? artists,
    List<FolderEntity>? folders,
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
      isSuccess: isSuccess ?? this.isSuccess,
      count: count ?? this.count,
    );
  }

  @override
  String toString() {
    return 'HomeState: \n'
        'isLoading: $isLoading, \n'
        'error: $error, \n'
        'songs: $songs, \n'
        'albums: $albums, \n'
        'artists: $artists, \n'
        'folders: $folders, \n'
        'isSuccess: $isSuccess, \n'
        'count: $count, \n';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is HomeState &&
        other.isLoading == isLoading &&
        other.error == error &&
        listEquals(other.songs, songs) &&
        listEquals(other.albums, albums) &&
        listEquals(other.artists, artists) &&
        listEquals(other.folders, folders) &&
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
        isSuccess.hashCode ^
        count.hashCode;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isLoading': isLoading});
    if (error != null) {
      result.addAll({'error': error!.toMap()});
    }
    if (songs != null) {
      result.addAll({'songs': songs!.map((x) => x.toMap()).toList()});
    }
    if (albums != null) {
      result.addAll({'albums': albums!.map((x) => x.toMap()).toList()});
    }
    if (artists != null) {
      result.addAll({'artists': artists!.map((x) => x.toMap()).toList()});
    }
    if (folders != null) {
      result.addAll({'folders': folders!.map((x) => x.toMap()).toList()});
    }
    result.addAll({'isSuccess': isSuccess});
    result.addAll({'count': count});

    return result;
  }

  factory HomeState.fromMap(Map<String, dynamic> map) {
    return HomeState(
      isLoading: map['isLoading'] ?? false,
      error:
          map['error'] != null ? AppErrorHandler.fromMap(map['error']) : null,
      songs: map['songs'] != null
          ? List<SongEntity>.from(
              map['songs']?.map(
                (x) => SongEntity.fromMap(
                  x,
                ),
              ),
            )
          : null,
      albums: map['albums'] != null
          ? List<AlbumEntity>.from(
              map['albums']?.map(
                (x) => AlbumEntity.fromMap(
                  x,
                ),
              ),
            )
          : null,
      artists: map['artists'] != null
          ? List<ArtistEntity>.from(
              map['artists']?.map(
                (x) => ArtistEntity.fromMap(
                  x,
                ),
              ),
            )
          : null,
      folders: map['folders'] != null
          ? List<FolderEntity>.from(
              map['folders']?.map(
                (x) => FolderEntity.fromMap(
                  x,
                ),
              ),
            )
          : null,
      isSuccess: map['isSuccess'] ?? false,
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeState.fromJson(String source) =>
      HomeState.fromMap(json.decode(source));
}

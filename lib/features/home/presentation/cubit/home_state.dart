// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
  final List<SongEntity>? favouriteSongs;
  final bool isSuccess;
  final int count;

  // Bottom Navigation Bar Selected Index
  final int selectedIndex;
  final PageController pageController;
  HomeState({
    required this.isLoading,
    required this.error,
    required this.songs,
    required this.albums,
    required this.artists,
    required this.folders,
    this.recentlyPlayed,
    this.favouriteSongs,
    required this.isSuccess,
    required this.count,
    required this.selectedIndex,
    required this.pageController,
  });

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      error: null,
      isSuccess: false,
      selectedIndex: 0,
      pageController: PageController(initialPage: 0),
      count: 0,
      songs: [],
      albums: [],
      artists: [],
      folders: [],
      favouriteSongs: [],
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
    List<SongEntity>? favouriteSongs,
    bool? isSuccess,
    int? count,
    int? selectedIndex,
    PageController? pageController,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      songs: songs ?? this.songs,
      albums: albums ?? this.albums,
      artists: artists ?? this.artists,
      folders: folders ?? this.folders,
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      favouriteSongs: favouriteSongs ?? this.favouriteSongs,
      isSuccess: isSuccess ?? this.isSuccess,
      count: count ?? this.count,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      pageController: pageController ?? this.pageController,
    );
  }

  @override
  String toString() {
    return 'HomeState(isLoading: $isLoading, error: $error, songs: $songs, albums: $albums, artists: $artists, folders: $folders, recentlyPlayed: $recentlyPlayed, favouriteSongs: $favouriteSongs, isSuccess: $isSuccess, count: $count, selectedIndex: $selectedIndex, pageController: $pageController)';
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.isLoading == isLoading &&
        other.error == error &&
        listEquals(other.songs, songs) &&
        listEquals(other.albums, albums) &&
        listEquals(other.artists, artists) &&
        listEquals(other.folders, folders) &&
        other.recentlyPlayed == recentlyPlayed &&
        listEquals(other.favouriteSongs, favouriteSongs) &&
        other.isSuccess == isSuccess &&
        other.count == count &&
        other.selectedIndex == selectedIndex &&
        other.pageController == pageController;
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
        favouriteSongs.hashCode ^
        isSuccess.hashCode ^
        count.hashCode ^
        selectedIndex.hashCode ^
        pageController.hashCode;
  }
}

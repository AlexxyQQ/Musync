import 'dart:developer';

import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:musync/features/home/data/data_source/music_local_data_source.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/repository/music_query_repository_a.dart';

class MusicQueryRepositoryImpl extends IMusicQueryRepository {
  final MusicLocalDataSource musicLocalDataSource;
  final OnAudioQuery onaudioQuery;

  MusicQueryRepositoryImpl({
    required this.musicLocalDataSource,
    required this.onaudioQuery,
  });

  @override
  Future<Map<String, List<SongEntity>>> getAllAlbumWithSongs() async {
    try {
      final data = await musicLocalDataSource.getAllAlbumWithSongs();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AlbumEntity>> getAllAlbums() async {
    try {
      final data = await musicLocalDataSource.getAllAlbums();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, List<SongEntity>>> getAllArtistWithSongs() async {
    try {
      final data = await musicLocalDataSource.getAllArtistWithSongs();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, List<SongEntity>>> getAllFolderWithSongs() async {
    try {
      final data = await musicLocalDataSource.getAllFolderWithSongs();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getAllFolders() async {
    try {
      final data = await musicLocalDataSource.getAllFolders();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SongEntity>> getAllSongs() async {
    try {
      final data = await musicLocalDataSource.getAllSongs();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SongEntity>> getFolderSongs({required String path}) async {
    try {
      final data = await musicLocalDataSource.getFolderSongs(path: path);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> permission() async {
    var perm = await Permission.storage.status;
    if (perm.isDenied) {
      try {
        await Permission.storage.request();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  Future<Map<String, Map<String, List<SongEntity>>>> getEverything() async {
    await permission();
    final folders = await getAllFolderWithSongs();
    final albums = await getAllAlbumWithSongs();
    final artists = await getAllArtistWithSongs();
    return {
      'folders': folders,
      'albums': albums,
      'artists': artists,
    };
  }

  @override
  Future<List<PlaylistEntity>> getAllPlaylists() async {
    try {
      final data = await musicLocalDataSource.getPlaylists();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createPlaylist({required String playlistName}) async {
    try {
      await musicLocalDataSource.createPlaylist(playlistName: playlistName);
    } catch (e) {
      rethrow;
    }
  }
}

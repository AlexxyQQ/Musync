import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

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
  }) : super() {
    permission();
  }

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
    final folders = await getAllFolderWithSongs();
    final albums = await getAllAlbumWithSongs();
    final artists = await getAllArtistWithSongs();
    return {
      'folders': folders,
      'albums': albums,
      'artists': artists,
    };
  }

  Future<String> saveAlbumArt({
    required int id,
    required ArtworkType type,
    required String fileName,
    int size = 200,
    int quality = 100,
    ArtworkFormat format = ArtworkFormat.PNG,
  }) async {
    final String tempPath =
        await path_provider.getTemporaryDirectory().then((value) => value.path);
    final File file = File('$tempPath/$fileName.png');

    if (!await file.exists()) {
      await file.create();
      final Uint8List? image = await onaudioQuery.queryArtwork(
        id,
        type,
        format: format,
        size: size,
        quality: quality,
      );
      if (image != null) {
        file.writeAsBytesSync(image);
      }
    }
    return file.path;
  }

  Future<Uint8List?> artwork(int id) async {
    return await onaudioQuery.queryArtwork(
      id,
      ArtworkType.AUDIO,
      size: 200,
      format: ArtworkFormat.PNG,
    );
  }
}

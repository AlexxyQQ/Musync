import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/data/data_source/music_remote_data_source.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:musync/features/home/data/data_source/music_local_data_source.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/repository/music_query_repository_a.dart';

class MusicQueryRepositoryImpl extends IMusicQueryRepository {
  final MusicLocalDataSource musicLocalDataSource;
  final MusicRemoteDataSource musicRemoteDataSource;
  final OnAudioQuery onaudioQuery;

  MusicQueryRepositoryImpl({
    required this.musicLocalDataSource,
    required this.musicRemoteDataSource,
    required this.onaudioQuery,
  });

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllAlbumWithSongs() async {
    try {
      final data = await musicLocalDataSource.getAllAlbumWithSongs();
      return data;
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, List<AlbumEntity>>> getAllAlbums() async {
    try {
      final data = await musicLocalDataSource.getAllAlbums();
      return data;
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllArtistWithSongs() async {
    try {
      final data = await musicLocalDataSource.getAllArtistWithSongs();
      return data;
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllFolderWithSongs() async {
    try {
      final data = await musicLocalDataSource.getAllFolderWithSongs();
      return data;
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, List<String>>> getAllFolders() async {
    try {
      final data = await musicLocalDataSource.getAllFolders();
      return data;
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, List<SongEntity>>> getAllSongs() async {
    try {
      final data = await musicLocalDataSource.getAllSongs();
      return data;
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, List<SongEntity>>> getFolderSongs({
    required String path,
  }) async {
    try {
      final data = await musicLocalDataSource.getFolderSongs(path: path);
      return data;
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, Map<String, Map<String, List<SongEntity>>>>>
      getEverything() async {
    try {
      await permission();
      final folders = await getAllFolderWithSongs();
      final albums = await getAllAlbumWithSongs();
      final artists = await getAllArtistWithSongs();
      return Right({
        'folders': folders.fold((l) => {}, (r) => r),
        'albums': albums.fold((l) => {}, (r) => r),
        'artists': artists.fold((l) => {}, (r) => r),
      });
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, List<PlaylistEntity>>> getAllPlaylists() async {
    try {
      final data = await musicLocalDataSource.getPlaylists();
      return data;
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, bool>> createPlaylist({
    required String playlistName,
  }) async {
    try {
      await musicLocalDataSource.createPlaylist(playlistName: playlistName);
      return right(true);
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, bool>> permission() async {
    var perm = await Permission.storage.status;
    if (perm.isDenied) {
      try {
        await Permission.storage.request();
        return const Right(true);
      } catch (e) {
        return Left(ErrorModel(message: e.toString(), status: false));
      }
    }
    return const Right(true);
  }

  @override
  Future<Either<ErrorModel, bool>> addAllSongs({
    required List<SongEntity> songs,
    required String token,
  }) async {
    try {
      await musicRemoteDataSource.addAllSongs(songs: songs, token: token);
      return right(true);
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }
}

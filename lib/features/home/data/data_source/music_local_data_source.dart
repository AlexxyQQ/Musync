import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/core/common/album_art_query_save.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/data/data_source/i_music_data_source.dart';
import 'package:musync/features/home/data/data_source/music_hive_data_source.dart';
import 'package:musync/features/home/data/model/album_hive_model.dart';
import 'package:musync/features/home/data/model/playlist_hive_model.dart';
import 'package:musync/features/home/data/model/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicLocalDataSource implements AMusicDataSource {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final musicHiveDataSource = GetIt.instance<MusicHiveDataSourse>();

  @override
  Future<Either<ErrorModel, List<SongEntity>>> getFolderSongs({
    required String path,
    required String token,
  }) async {
    try {
      var allHiveFolderSongs =
          await musicHiveDataSource.getFolderSongs(path: path);
      if (allHiveFolderSongs.isNotEmpty) {
        var allEntitySongs =
            SongHiveModel.empty().toEntityList(allHiveFolderSongs);
        return Right(allEntitySongs);
      } else {
        final List<SongModel> allQuerySongs = await audioQuery.querySongs(
          path: path,
          sortType: SongSortType.ALBUM,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );

        List<SongEntity> songEntityList = [];
        if (allQuerySongs != null) {
          for (var songMap in allQuerySongs) {
            // query and save album art in directory and return the path
            final String albumArt =
                await AlbumArtQuerySave(audioQuery: audioQuery).saveAlbumArt(
              id: songMap.id,
              type: ArtworkType.AUDIO,
              fileName: songMap.displayNameWOExt,
            );
            final convertedMap = convertMap(songMap.getMap);
            // add album art path to converted map
            convertedMap["albumArt"] = albumArt;
            songEntityList.add(
              SongEntity.fromModelMap(convertedMap),
            );
          }
        }
        return Right(songEntityList);
      }
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, List<AlbumEntity>>> getAllAlbums({
    required String token,
  }) async {
    try {
      var allQueryAlbums = await audioQuery.queryAlbums(
        sortType: AlbumSortType.ALBUM,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
      List<AlbumEntity> albumEntityList = [];
      if (allQueryAlbums != null) {
        for (var albumMap in allQueryAlbums) {
          albumEntityList
              .add(AlbumEntity.fromAlbumModel(convertMap(albumMap.getMap)));
        }
      }
      var albumHiveList = AlbumHiveModel.empty().toHiveList(albumEntityList);
      await musicHiveDataSource.addAllAlbums(albumHiveList);
      return Right(albumEntityList);
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, List<String>>> getAllFolders({
    required String token,
  }) async {
    try {
      var allSongFolders = await musicHiveDataSource.getAllFolders();
      if (allSongFolders.isNotEmpty) {
        return Right(allSongFolders);
      } else {
        final List<String> allSongFolders = await audioQuery.queryAllPath();
        await musicHiveDataSource.addAllFolders(allSongFolders);
        return Right(allSongFolders);
      }
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllFolderWithSongs({
    required String token,
  }) async {
    try {
      final Map<String, List<SongEntity>> result = {};
      final Either<ErrorModel, List<String>> foldersEither =
          await getAllFolders(token: token);
      return foldersEither.fold(
        (error) => Left(error),
        (allFolder) async {
          for (String folderPath in allFolder) {
            final Either<ErrorModel, List<SongEntity>> songsEither =
                await getFolderSongs(path: folderPath, token: token);
            songsEither.fold(
              (error) => Left(error),
              (folderSongEntityList) =>
                  result[folderPath] = folderSongEntityList,
            );
          }
          return Right(result);
        },
      );
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllArtistWithSongs({
    required String token,
  }) async {
    try {
      final Map<String, List<SongEntity>> result = {};
      final Either<ErrorModel, List<SongEntity>> allSongsEither =
          await getAllSongs();
      return allSongsEither.fold(
        (error) => Left(error),
        (allSongs) {
          for (SongEntity song in allSongs) {
            final artistSongs = allSongs
                .where(
                    (element) => element.artistId.toString() == song.artistId)
                .toList();
            result[song.artist ?? 'Unknown'] = artistSongs;
          }
          return Right(result);
        },
      );
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, bool>> createPlaylist({
    required String playlistName,
    required String token,
  }) async {
    try {
      final Either<ErrorModel, List<PlaylistEntity>> playlists =
          await getPlaylists(token: token);
      bool playlistExists = playlists.fold(
        (error) => false,
        (playlistList) =>
            playlistList.any((playlist) => playlist.playlist == playlistName),
      );

      if (!playlistExists) {
        await audioQuery.createPlaylist(playlistName);
      }

      return const Right(true);
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, bool>> addToPlaylist({
    required int playlistId,
    required int audioId,
    required String token,
  }) async {
    await audioQuery.addToPlaylist(playlistId, audioId);
    return const Right(true);
  }

  @override
  Future<Either<ErrorModel, List<PlaylistEntity>>> getPlaylists({
    required String token,
  }) async {
    audioQuery.queryPlaylists();
    var allHivePlaylists = await musicHiveDataSource.getAllPlaylist();
    if (allHivePlaylists.isNotEmpty) {
      var allEntitySongs =
          PlaylistHiveModel.empty().toEntityList(allHivePlaylists);
      return Right(allEntitySongs);
    } else {
      final List<PlaylistModel> allQueryPlaylists =
          await audioQuery.queryPlaylists();
      List<PlaylistEntity> songEntityList = [];
      if (allQueryPlaylists != null) {
        for (var playlist in allQueryPlaylists) {
          songEntityList.add(
            PlaylistEntity.fromMap(
              convertMap(playlist.getMap),
            ),
          );
        }
      }
      var songHiveList = PlaylistHiveModel.empty().toHiveList(songEntityList);
      await musicHiveDataSource.addAllPlaylist(songHiveList);
      return Right(songEntityList);
    }
  }

  Map<String, dynamic> convertMap(Map<dynamic, dynamic> originalMap) {
    Map<String, dynamic> convertedMap = {};
    originalMap.forEach((key, value) {
      if (key is String) {
        convertedMap[key] = value;
      } else {
        convertedMap[key.toString()] = value;
      }
    });
    return convertedMap;
  }

  @override
  Future<Either<ErrorModel, bool>> addAlbums({
    required String token,
  }) async {
    try {
      var allAlbums = await audioQuery.queryAlbums(
        sortType: AlbumSortType.ALBUM,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      if (allAlbums.isNotEmpty) {
        List<AlbumEntity> albumEntityList = [];
        for (var albumMap in allAlbums) {
          albumEntityList.add(
            AlbumEntity.fromMap(convertMap(albumMap.getMap)),
          );
        }

        var albumHiveList = AlbumHiveModel.empty().toHiveList(albumEntityList);
        await musicHiveDataSource.addAllAlbums(albumHiveList);
      }

      return const Right(true);
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, bool>> addFolders({
    required String token,
  }) async {
    var allSongFolders = await audioQuery.queryAllPath();
    if (allSongFolders.isNotEmpty) {
      await musicHiveDataSource.addAllFolders(allSongFolders);
    }
    return const Right(true);
  }

  @override
  Future<Either<ErrorModel, bool>> addAllSongs({
    required String? token,
    List<SongHiveModel>? songs,
  }) async {
    await musicHiveDataSource.addAllSongs(songs ?? []);
    return const Right(true);
  }

  @override
  Future<Either<ErrorModel, List<SongEntity>>> getAllSongs({
    String? token,
  }) async {
    final box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    box.clear();
    var allHiveSongs = await musicHiveDataSource.getAllSongs();
    if (allHiveSongs.isNotEmpty) {
      var allEntitySongs =
          SongHiveModel.empty().toCheckEntityList(allHiveSongs);
      return Right(allEntitySongs);
    } else {
      final List<SongModel> allQuerySongs = await audioQuery.querySongs(
        sortType: SongSortType.ALBUM,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
      List<SongEntity> songEntityList = [];
      if (allQuerySongs != null) {
        for (var songMap in allQuerySongs) {
          // query and save album art in directory and return the path
          final String albumArt =
              await AlbumArtQuerySave(audioQuery: audioQuery).saveAlbumArt(
            id: songMap.id,
            type: ArtworkType.AUDIO,
            fileName: songMap.displayNameWOExt,
          );
          final convertedMap = convertMap(songMap.getMap);
          // add album art path to converted map
          convertedMap["albumArt"] = albumArt;

          songEntityList.add(
            SongEntity.fromModelMap(convertedMap),
          );
        }
      }

      var songHiveList = SongHiveModel.empty().toHiveList(songEntityList);
      await musicHiveDataSource.addAllSongs(songHiveList);
      return Right(songEntityList);
    }
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllAlbumWithSongs({required String token}) async {
    try {
      final Map<String, List<SongEntity>> result = {};
      final Either<ErrorModel, List<AlbumEntity>> albumsEither =
          await getAllAlbums(token: token);
      final Either<ErrorModel, List<SongEntity>> songsEither =
          await getAllSongs();

      return albumsEither.fold(
        (error) => Left(error),
        (allAlbums) {
          return songsEither.fold(
            (error) => Left(error),
            (allSongs) {
              for (AlbumEntity album in allAlbums) {
                final albumSongs = allSongs
                    .where((element) => element.albumId.toString() == album.id)
                    .toList();
                result[album.id] = albumSongs;
              }
              return Right(result);
            },
          );
        },
      );
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }
}
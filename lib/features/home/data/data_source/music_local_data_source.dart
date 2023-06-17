import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/data/data_source/music_data_source.dart';
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
            songEntityList.add(
              SongEntity.fromModelMap(
                convertMap(songMap.getMap),
              ),
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
  Future<Either<ErrorModel, List<AlbumEntity>>> getAllAlbums() async {
    try {
      const MethodChannel channel =
          MethodChannel('com.lucasjosino.on_audio_query');

      var allQueryAlbums = await channel.invokeMethod(
        "queryAlbums",
        {
          "albumSortType": AlbumSortType.ALBUM.index,
          "orderType": OrderType.ASC_OR_SMALLER.index,
          "uri": UriType.EXTERNAL.index,
          "ignoreCase": true,
        },
      );
      List<AlbumEntity> albumEntityList = [];
      if (allQueryAlbums != null) {
        for (var albumMap in allQueryAlbums) {
          albumEntityList.add(AlbumEntity.fromMap(convertMap(albumMap)));
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
  Future<Either<ErrorModel, List<String>>> getAllFolders() async {
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
      getAllFolderWithSongs() async {
    try {
      final Map<String, List<SongEntity>> result = {};
      final Either<ErrorModel, List<String>> foldersEither =
          await getAllFolders();
      return foldersEither.fold(
        (error) => Left(error),
        (allFolder) async {
          for (String folderPath in allFolder) {
            final Either<ErrorModel, List<SongEntity>> songsEither =
                await getFolderSongs(path: folderPath);
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
      getAllArtistWithSongs() async {
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
  Future<Either<ErrorModel, bool>> createPlaylist(
      {required String playlistName}) async {
    try {
      final Either<ErrorModel, List<PlaylistEntity>> playlists =
          await getPlaylists();
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
  Future<Either<ErrorModel, bool>> addToPlaylist(
      {required int playlistId, required int audioId}) async {
    await audioQuery.addToPlaylist(playlistId, audioId);
    return const Right(true);
  }

  @override
  Future<Either<ErrorModel, List<PlaylistEntity>>> getPlaylists() async {
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
  Future<Either<ErrorModel, bool>> addAlbums() async {
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
  Future<Either<ErrorModel, bool>> addFolders() async {
    var allSongFolders = await audioQuery.queryAllPath();
    if (allSongFolders.isNotEmpty) {
      await musicHiveDataSource.addAllFolders(allSongFolders);
    }
    return const Right(true);
  }

  @override
  Future<Either<ErrorModel, bool>> addAllSongs({
    required List<SongEntity> songs,
    required String? token,
  }) async {
    if (songs.isNotEmpty) {
      var songHiveList = SongHiveModel.empty().toHiveList(songs);
      await musicHiveDataSource.addAllSongs(songHiveList);
    }
    return const Right(true);
  }

  @override
  Future<Either<ErrorModel, List<SongEntity>>> getAllSongs({
    String? token,
  }) async {
    var allHiveSongs = await musicHiveDataSource.getAllSongs();
    if (allHiveSongs.isNotEmpty) {
      var allEntitySongs = SongHiveModel.empty().toEntityList(allHiveSongs);
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
          songEntityList.add(
            SongEntity.fromModelMap(
              convertMap(songMap.getMap),
            ),
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
      getAllAlbumWithSongs() async {
    try {
      final Map<String, List<SongEntity>> result = {};
      final Either<ErrorModel, List<AlbumEntity>> albumsEither =
          await getAllAlbums();
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

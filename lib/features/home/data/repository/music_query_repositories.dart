import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/utils/connectivity_check.dart';
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
      getAllAlbumWithSongs({required String token}) async {
    try {
      final isConnected = await ConnectivityCheck.connectivity();
      final isServerUp = await ConnectivityCheck.isServerup();

      if (isConnected && isServerUp) {
        final remoteAlbumWithSongsEither =
            await musicRemoteDataSource.getAllAlbumWithSongs(token: token);
        final remoteAlbumWithSongs = remoteAlbumWithSongsEither.fold(
          (error) => <String, List<SongEntity>>{},
          (remoteSongs) => remoteSongs,
        );

        final localAlbumWithSongsEither =
            await musicLocalDataSource.getAllAlbumWithSongs(token: token);
        final localAlbumWithSongs = localAlbumWithSongsEither.fold(
          (error) => <String, List<SongEntity>>{},
          (localSongs) => localSongs,
        );

        final mergedAlbumWithSongs = <String, List<SongEntity>>{};

        // Merge remote and local songs
        for (final entry in remoteAlbumWithSongs.entries) {
          mergedAlbumWithSongs[entry.key] = entry.value;
        }

        // Add local songs to mergedAlbumWithSongs only if they don't already exist
        for (final entry in localAlbumWithSongs.entries) {
          if (!mergedAlbumWithSongs.containsKey(entry.key)) {
            mergedAlbumWithSongs[entry.key] = entry.value;
          }
        }

        return Right(mergedAlbumWithSongs);
      } else {
        final localAlbumWithSongsEither =
            await musicLocalDataSource.getAllAlbumWithSongs(token: token);

        return localAlbumWithSongsEither;
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
      if (await ConnectivityCheck.connectivity() &&
          await ConnectivityCheck.isServerup()) {
        final remoteAllAlbumsEither =
            await musicRemoteDataSource.getAllAlbumWithSongs(token: token);
        final remoteAllAlbums = remoteAllAlbumsEither.fold(
          (error) => {},
          (remoteSongs) => remoteSongs,
        );

        final localAllAlbumsEither =
            await musicLocalDataSource.getAllAlbumWithSongs(token: token);
        final locaAllAlbums = localAllAlbumsEither.fold(
          (error) => {},
          (localSongs) => localSongs,
        );

        if (remoteAllAlbums != {}) {
          final List<AlbumEntity> mergedSongs = [];

          //  if remote is in local then show remote
          for (final entry in remoteAllAlbums.entries) {
            //  if remote is in local then show remote
            if (locaAllAlbums.containsKey(entry.key)) {
              mergedSongs.add(
                AlbumEntity(
                  album: entry.key,
                  artist: entry.value[0].artist,
                  id: entry.value[0].albumId,
                  artistId: entry.value[0].artistId,
                  numOfSongs: entry.value.length,
                ),
              );
            } else {
              mergedSongs.add(
                AlbumEntity(
                  album: entry.key,
                  artist: entry.value[0].artist,
                  id: entry.value[0].albumId,
                  artistId: entry.value[0].artistId,
                  numOfSongs: entry.value.length,
                ),
              );
            }
          }

          return Right(mergedSongs);
        } else {
          final List<AlbumEntity> mergedSongs = [];

          //  if remote is in local then show remote
          for (final entry in locaAllAlbums.entries) {
            //  if remote is in local then show remote
            if (remoteAllAlbums.containsKey(entry.key)) {
              mergedSongs.add(
                AlbumEntity(
                  album: entry.key,
                  artist: entry.value[0].artist,
                  id: entry.value[0].albumId,
                  artistId: entry.value[0].artistId,
                  numOfSongs: entry.value.length,
                ),
              );
            } else {
              mergedSongs.add(
                AlbumEntity(
                  album: entry.key,
                  artist: entry.value[0].artist,
                  id: entry.value[0].albumId,
                  artistId: entry.value[0].artistId,
                  numOfSongs: entry.value.length,
                ),
              );
            }
          }
          return Right(mergedSongs);
        }
      } else {
        // If the connectivity or server is not available, return local songs only
        final localAllAlbumsEither =
            await musicLocalDataSource.getAllAlbumWithSongs(token: '');
        final localAllAlbums = localAllAlbumsEither.fold(
          (error) => {},
          (localSongs) => localSongs,
        );

        final List<AlbumEntity> mergedSongs = [];

        //  if remote is in local then show remote
        for (final entry in localAllAlbums.entries) {
          //  if remote is in local then show remote
          if (localAllAlbums.containsKey(entry.key)) {
            mergedSongs.add(
              AlbumEntity(
                album: entry.key,
                artist: entry.value[0].artist,
                id: entry.value[0].albumId,
                artistId: entry.value[0].artistId,
                numOfSongs: entry.value.length,
              ),
            );
          } else {
            mergedSongs.add(
              AlbumEntity(
                album: entry.key,
                artist: entry.value[0].artist,
                id: entry.value[0].albumId,
                artistId: entry.value[0].artistId,
                numOfSongs: entry.value.length,
              ),
            );
          }
        }
        return Right(mergedSongs);
      }
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllArtistWithSongs({
    required String token,
  }) async {
    try {
      final isConnected = await ConnectivityCheck.connectivity();
      final isServerUp = await ConnectivityCheck.isServerup();

      if (isConnected && isServerUp) {
        final remoteAllArtistWithSongsEither =
            await musicRemoteDataSource.getAllArtistWithSongs(token: token);
        final remoteAllArtistWithSongs = remoteAllArtistWithSongsEither.fold(
          (error) => <String, List<SongEntity>>{},
          (remoteSongs) => remoteSongs,
        );

        final localAllArtistWithSongsEither =
            await musicLocalDataSource.getAllArtistWithSongs(token: token);
        final localAllArtistWithSongs = localAllArtistWithSongsEither.fold(
          (error) => <String, List<SongEntity>>{},
          (localSongs) => localSongs,
        );

        final mergedSongs = <String, List<SongEntity>>{};

        // Add remote artist songs to mergedSongs
        for (final entry in remoteAllArtistWithSongs.entries) {
          mergedSongs[entry.key] = entry.value;
        }

        // Add local artist songs to mergedSongs only if they don't already exist
        for (final entry in localAllArtistWithSongs.entries) {
          if (!mergedSongs.containsKey(entry.key)) {
            mergedSongs[entry.key] = entry.value;
          }
        }

        return Right(mergedSongs);
      } else {
        final localAllArtistWithSongsEither =
            await musicLocalDataSource.getAllArtistWithSongs(token: token);

        return localAllArtistWithSongsEither;
      }
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllFolderWithSongs({
    required String token,
  }) async {
    try {
      final isConnected = await ConnectivityCheck.connectivity();
      final isServerUp = await ConnectivityCheck.isServerup();

      if (isConnected && isServerUp) {
        final remoteAllFolderWithSongsEither =
            await musicRemoteDataSource.getAllFolderWithSongs(token: token);
        final remoteAllFolderWithSongs = remoteAllFolderWithSongsEither.fold(
          (error) => <String, List<SongEntity>>{},
          (remoteSongs) => remoteSongs,
        );

        final localAllFolderWithSongsEither =
            await musicLocalDataSource.getAllFolderWithSongs(token: token);
        final localAllFolderWithSongs = localAllFolderWithSongsEither.fold(
          (error) => <String, List<SongEntity>>{},
          (localSongs) => localSongs,
        );

        final mergedSongs = <String, List<SongEntity>>{};

        // Add remote songs to mergedSongs
        for (final remoteEntry in remoteAllFolderWithSongs.entries) {
          mergedSongs[remoteEntry.key] = remoteEntry.value;
        }

        // Add local songs to mergedSongs
        for (final localEntry in localAllFolderWithSongs.entries) {
          // Add only if the folder doesn't exist in remoteAllFolderWithSongs
          if (!mergedSongs.containsKey(localEntry.key)) {
            mergedSongs[localEntry.key] = localEntry.value;
          }
        }

        return Right(mergedSongs);
      } else {
        final localAllFolderWithSongsEither =
            await musicLocalDataSource.getAllFolderWithSongs(token: token);

        return localAllFolderWithSongsEither;
      }
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, List<String>>> getAllFolders({
    required String token,
  }) async {
    try {
      final isConnected = await ConnectivityCheck.connectivity();
      final isServerUp = await ConnectivityCheck.isServerup();

      if (isConnected && isServerUp) {
        final remoteFoldersListEither =
            await musicRemoteDataSource.getAllFolders(token: token);
        final remoteFoldersList = remoteFoldersListEither.fold(
          (error) => <String>[],
          (remoteFolders) => remoteFolders,
        );

        final localFoldersListEither =
            await musicLocalDataSource.getAllFolders(token: token);
        final localFoldersList = localFoldersListEither.fold(
          (error) => <String>[],
          (localFolders) => localFolders,
        );

        final mergedFolders = <String>[];

        // Add remote folders to mergedFolders
        for (final entry in remoteFoldersList) {
          mergedFolders.add(entry);
        }

        // Add local folders to mergedFolders only if they don't already exist
        for (final entry in localFoldersList) {
          if (!mergedFolders.contains(entry)) {
            mergedFolders.add(entry);
          }
        }

        return Right(mergedFolders);
      } else {
        final localFoldersListEither =
            await musicLocalDataSource.getAllFolders(token: token);

        return localFoldersListEither;
      }
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, List<SongEntity>>> getAllSongs({
    required String token,
  }) async {
    try {
      if (await ConnectivityCheck.connectivity() &&
          await ConnectivityCheck.isServerup()) {
        final remoteSongsListEither =
            await musicRemoteDataSource.getAllSongs(token: token);
        final remoteSongsList = remoteSongsListEither.fold(
          (error) => [],
          (remoteSongs) => remoteSongs,
        );

        final localSongsListEither = await musicLocalDataSource.getAllSongs();
        final localSongsList = localSongsListEither.fold(
          (error) => [],
          (localSongs) => localSongs,
        );

        final List<SongEntity> mergedSongs = [];

        for (var remoteSong in remoteSongsList) {
          mergedSongs.add(remoteSong);
        }

        for (var localSong in localSongsList) {
          final isSongExistsInRemote = remoteSongsList.any(
            (remoteSong) => remoteSong.id == localSong.id,
          );
          if (!isSongExistsInRemote) {
            mergedSongs.add(localSong);
          }
        }

        return Right(mergedSongs);
      } else {
        final localSongsListEither = await musicLocalDataSource.getAllSongs();
        return localSongsListEither;
      }
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, List<SongEntity>>> getFolderSongs({
    required String path,
    required String token,
  }) async {
    try {
      final isConnected = await ConnectivityCheck.connectivity();
      final isServerUp = await ConnectivityCheck.isServerup();

      if (isConnected && isServerUp) {
        final remoteSongsListEither = await musicRemoteDataSource
            .getFolderSongs(path: path, token: token);
        final remoteSongsList = remoteSongsListEither.fold(
          (error) => <SongEntity>[],
          (remoteSongs) => remoteSongs,
        );

        final localSongsListEither =
            await musicLocalDataSource.getFolderSongs(path: path, token: token);
        final localSongsList = localSongsListEither.fold(
          (error) => <SongEntity>[],
          (localSongs) => localSongs,
        );

        final mergedSongs = <SongEntity>[];

        // Add remote songs to mergedSongs only if they don't already exist in the local songs list
        for (final remoteSong in remoteSongsList) {
          final isLocalSongExists =
              localSongsList.any((localSong) => localSong.id == remoteSong.id);
          if (!isLocalSongExists) {
            mergedSongs.add(remoteSong);
          }
        }

        return Right(mergedSongs); // Return mergedSongs if it's not empty
      } else {
        final localSongsListEither =
            await musicLocalDataSource.getFolderSongs(path: path, token: token);
        return localSongsListEither;
      }
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, Map<String, Map<String, List<SongEntity>>>>>
      getEverything({
    required String token,
  }) async {
    try {
      await permission();
      final folders = await getAllFolderWithSongs(token: token);
      final albums = await getAllAlbumWithSongs(token: token);
      final artists = await getAllArtistWithSongs(token: token);
      final songs = await getAllSongs(token: token);

      return Right({
        'folders': folders.fold((l) => {}, (r) => r),
        'albums': albums.fold((l) => {}, (r) => r),
        'artists': artists.fold((l) => {}, (r) => r),
        'songs': songs.fold(
          (l) => {},
          (r) => {
            'all': r,
          },
        ),
      });
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }

  @override
  Future<Either<ErrorModel, List<PlaylistEntity>>> getAllPlaylists({
    required String token,
  }) async {
    try {
      final data = await musicLocalDataSource.getPlaylists(token: token);
      return data;
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
      await musicLocalDataSource.createPlaylist(
        playlistName: playlistName,
        token: token,
      );
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
    required String token,
  }) async {
    try {
      await musicRemoteDataSource.addAllSongs(token: token);
      return right(true);
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }
  }
}

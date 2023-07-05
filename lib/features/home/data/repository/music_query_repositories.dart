import 'dart:developer';

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
      if (await ConnectivityCheck.connectivity() &&
          await ConnectivityCheck.isServerup()) {
        final remoteAlbumWithSongsEither =
            await musicRemoteDataSource.getAllAlbumWithSongs(token: token);
        final remoteAlbumWithSongs = remoteAlbumWithSongsEither.fold(
          (error) => {},
          (remoteSongs) => remoteSongs,
        );

        final localAlbumWithSongsEither =
            await musicLocalDataSource.getAllAlbumWithSongs(token: token);

        final localAlbumWithSongs = localAlbumWithSongsEither.fold(
          (error) => {},
          (localSongs) => localSongs,
        );

        if (remoteAlbumWithSongs.isNotEmpty) {
          final mergedAlbumWithSongs = <String, List<SongEntity>>{};

          // Merge remote and local songs
          for (final entry in remoteAlbumWithSongs.entries) {
            //  if remote is in local then show remote
            if (localAlbumWithSongs.containsKey(entry.key)) {
              mergedAlbumWithSongs[entry.key] = entry.value;
            } else {
              mergedAlbumWithSongs[entry.key] = entry.value;
            }
          }

          return Right(mergedAlbumWithSongs);
        } else {
          return localAlbumWithSongsEither;
        }
      } else {
        final localAlbumWithSongsEither =
            await musicLocalDataSource.getAllAlbumWithSongs(token: token);
        final localAlbumWithSongs = localAlbumWithSongsEither.fold(
          (error) => {} as Map<String, List<SongEntity>>,
          (localSongs) => localSongs,
        );

        return Right(localAlbumWithSongs);
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
      if (await ConnectivityCheck.connectivity() &&
          await ConnectivityCheck.isServerup()) {
        final remoteAllArtistWithSongsEither =
            await musicRemoteDataSource.getAllArtistWithSongs(token: token);
        final remoteAllArtistWithSongs = remoteAllArtistWithSongsEither.fold(
          (error) => {},
          (remoteSongs) => remoteSongs,
        );

        final localAllArtistWithSongsEither =
            await musicLocalDataSource.getAllArtistWithSongs(token: token);
        final locaAllArtistWithSongs = localAllArtistWithSongsEither.fold(
          (error) => {},
          (localSongs) => localSongs,
        );

        if (remoteAllArtistWithSongs.isNotEmpty) {
          final Map<String, List<SongEntity>> mergedSongs = {};

          //  if remote is in local then show remote
          for (final entry in remoteAllArtistWithSongs.entries) {
            //  if remote is in local then show remote
            if (locaAllArtistWithSongs.containsKey(entry.key)) {
              mergedSongs[entry.key] = entry.value;
            } else {
              mergedSongs[entry.key] = entry.value;
            }
          }

          return Right(mergedSongs);
        } else {
          return localAllArtistWithSongsEither;
        }
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

    // try {
    //   final data =
    //       await musicLocalDataSource.getAllArtistWithSongs(token: token);
    //   return data;
    // } catch (e) {
    //   return Left(ErrorModel(message: e.toString(), status: false));
    // }
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllFolderWithSongs({
    required String token,
  }) async {
    try {
      if (await ConnectivityCheck.connectivity() &&
          await ConnectivityCheck.isServerup()) {
        final remoteAllFolderWithSongsEither =
            await musicRemoteDataSource.getAllFolderWithSongs(token: token);
        final remoteAllFolderWithSongs = remoteAllFolderWithSongsEither.fold(
          (error) => {},
          (remoteSongs) => remoteSongs,
        );

        final localAllFolderWithSongsEither =
            await musicLocalDataSource.getAllFolderWithSongs(token: token);
        final localAllFolderWithSongs = localAllFolderWithSongsEither.fold(
          (error) => {},
          (localSongs) => localSongs,
        );

        final Map<String, List<SongEntity>> mergedSongs = {};

        // Add local songs to mergedSongs
        for (final localValues in localAllFolderWithSongs.values) {
          String folderPath = localValues[0]
              .data
              .split('/')
              .sublist(0, localValues[0].data.split('/').length - 1)
              .join('/');
          mergedSongs[folderPath] = localValues;
        }

        // Add remote songs to mergedSongs if they are not present in local songs
        for (final remoteValues in remoteAllFolderWithSongs.values) {
          for (var remoteSongs in remoteValues) {
            bool foundInLocal = false;
            for (final localValues in localAllFolderWithSongs.values) {
              for (var localSongs in localValues) {
                if (localSongs.id == remoteSongs.id) {
                  foundInLocal = true;
                  break;
                }
              }
              if (foundInLocal) {
                break;
              }
            }

            if (!foundInLocal) {
              // var folderPath =
              //     remoteSongs.data.split('/').sublist(0, -1).join('/');
              String folderPath = remoteSongs.data
                  .split('/')
                  .sublist(0, remoteSongs.data.split('/').length - 1)
                  .join('/');

              mergedSongs[folderPath] = remoteValues;
            }
          }
        }
        print("mergedSongs $mergedSongs");

        return Right(mergedSongs);
      } else {
        final localAllFolderWithSongsEither =
            await musicLocalDataSource.getAllFolderWithSongs(token: token);
        return localAllFolderWithSongsEither;
      }
    } catch (e) {
      print("error $e");
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }
    // try {
    //   if (await ConnectivityCheck.connectivity() &&
    //       await ConnectivityCheck.isServerup()) {
    //     final remoteAllFolderWithSongsEither =
    //         await musicRemoteDataSource.getAllFolderWithSongs(token: token);
    //     final remoteAllFolderWithSongs = remoteAllFolderWithSongsEither.fold(
    //       (error) => {},
    //       (remoteSongs) => remoteSongs,
    //     );

    //     final localAllFolderWithSongsEither =
    //         await musicLocalDataSource.getAllFolderWithSongs(token: token);
    //     final locaAllFolderWithSongs = localAllFolderWithSongsEither.fold(
    //       (error) => {},
    //       (localSongs) => localSongs,
    //     );

    //     if (remoteAllFolderWithSongs.isNotEmpty) {
    //       final Map<String, List<SongEntity>> mergedSongs = {};

    //       //  if remote is in local then show remote
    //       for (final remoteValues in remoteAllFolderWithSongs.values) {
    //         for (var localValues in locaAllFolderWithSongs.values) {
    //           if (remoteValues[0].id == localValues[0].id) {
    //             mergedSongs[remoteValues[0].folder] = remoteValues;
    //           } else {
    //             mergedSongs[remoteValues[0].folder] = remoteValues;
    //           }
    //         }
    //       }
    //       print('mergedSongs: $mergedSongs');

    //       return Right(mergedSongs);
    //     } else {
    //       return localAllFolderWithSongsEither;
    //     }
    //   } else {
    //     final localAllFolderWithSongsEither =
    //         await musicLocalDataSource.getAllFolderWithSongs(token: token);
    //     return localAllFolderWithSongsEither;
    //   }
    // } catch (e) {
    //   return Left(
    //     ErrorModel(
    //       message: e.toString(),
    //       status: false,
    //     ),
    //   );
    // }
  }

  @override
  Future<Either<ErrorModel, List<String>>> getAllFolders({
    required String token,
  }) async {
    try {
      if (await ConnectivityCheck.connectivity() &&
          await ConnectivityCheck.isServerup()) {
        final remoteFoldersListEither =
            await musicRemoteDataSource.getAllFolders(token: token);
        final remoteFoldersList = remoteFoldersListEither.fold(
          (error) => [],
          (remoteFolders) => remoteFolders,
        );

        final localFoldersListEither =
            await musicLocalDataSource.getAllFolders(token: token);
        final localFoldersList = localFoldersListEither.fold(
          (error) => [],
          (localFolders) => localFolders,
        );

        if (remoteFoldersList != []) {
          final List<String> mergedFolders = [];

          //  if remote is in local then show remote
          for (final entry in remoteFoldersList) {
            //  if remote is in local then show remote
            if (localFoldersList.contains(entry)) {
              mergedFolders.add(entry);
            } else {
              mergedFolders.add(entry);
            }
          }

          return Right(mergedFolders);
        } else {
          final List<String> mergedFolders = [];

          //  if remote is in local then show remote
          for (final entry in localFoldersList) {
            //  if remote is in local then show remote
            if (remoteFoldersList.contains(entry)) {
              mergedFolders.add(entry);
            } else {
              mergedFolders.add(entry);
            }
          }
          return Right(mergedFolders);
        }
      } else {
        final localFoldersListEither =
            await musicLocalDataSource.getAllFolders(token: token);
        final localFoldersList = localFoldersListEither.fold(
          (error) => [],
          (localFolders) => localFolders,
        );

        final List<String> mergedFolders = [];

        //  if remote is in local then show remote
        for (final entry in localFoldersList) {
          //  if remote is in local then show remote
          if (localFoldersList.contains(entry)) {
            mergedFolders.add(entry);
          } else {
            mergedFolders.add(entry);
          }
        }
        return Right(mergedFolders);
      }
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
          status: false,
        ),
      );
    }

    // try {
    //   final data = await musicLocalDataSource.getAllFolders(token: token);
    //   return data;
    // } catch (e) {
    //   return Left(ErrorModel(message: e.toString(), status: false));
    // }
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

        // if remote songs is in the local songs list then show the remote songs

        if (remoteSongsList.isNotEmpty) {
          final List<SongEntity> mergedSongs = [];

          for (var remoteSong in remoteSongsList.cast<SongEntity>()) {
            final isLocalSongExists = localSongsList
                .any((localSong) => localSong.id == remoteSong.id);
            if (!isLocalSongExists) {
              mergedSongs.add(remoteSong);
            }
          }

          return Right(mergedSongs); // Return mergedSongs if it's not empty
        } else {
          return localSongsListEither;
        }
      } else {
        final data = await musicLocalDataSource.getAllSongs();
        return data;
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
      if (await ConnectivityCheck.connectivity() &&
          await ConnectivityCheck.isServerup()) {
        final remoteSongsListEither = await musicRemoteDataSource
            .getFolderSongs(path: path, token: token);
        final remoteSongsList = remoteSongsListEither.fold(
          (error) => [],
          (remoteSongs) => remoteSongs,
        );

        final localSongsListEither =
            await musicLocalDataSource.getFolderSongs(path: path, token: token);
        final localSongsList = localSongsListEither.fold(
          (error) => [],
          (localSongs) => localSongs,
        );

        // if remote songs is in the local songs list then show the remote songs

        if (remoteSongsList.isNotEmpty) {
          final List<SongEntity> mergedSongs = [];

          for (var remoteSong in remoteSongsList.cast<SongEntity>()) {
            final isLocalSongExists = localSongsList
                .any((localSong) => localSong.id == remoteSong.id);
            if (!isLocalSongExists) {
              mergedSongs.add(remoteSong);
            }
          }

          return Right(mergedSongs); // Return mergedSongs if it's not empty
        } else {
          return localSongsListEither;
        }
      } else {
        final data =
            await musicLocalDataSource.getFolderSongs(path: path, token: token);
        return data;
      }
    } catch (e) {
      return Left(ErrorModel(message: e.toString(), status: false));
    }

    // try {
    //   final data =
    //       await musicLocalDataSource.getFolderSongs(path: path, token: token);
    //   return data;
    // } catch (e) {
    //   return Left(ErrorModel(message: e.toString(), status: false));
    // }
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

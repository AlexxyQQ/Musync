import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/data/data_source/local_data_source/local_data_source.dart';
import 'package:musync/features/home/data/data_source/remote_data_source/remote_data_source.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/utils/connectivity_check.dart';
import '../model/app_album_model.dart';
import '../model/app_artist_model.dart';
import '../model/app_folder_model.dart';
import '../model/app_song_model.dart';
import 'local_data_source/hive_service/query_hive_service.dart';

abstract class IAudioQueryDataSource {
  // Songs
  Future<Either<AppErrorHandler, List<AppSongModel>>> getAllSongs({
    required Function(int) onProgress,
    bool? first,
    bool? refetch,
    required String token,
  });

  Future<Either<AppErrorHandler, String>> updateSong({
    required AppSongModel song,
    required String token,
    required bool offline,
  });

  Future<Either<AppErrorHandler, String>> addSong({
    required AppSongModel song,
    required String token,
  });

  Future<Either<AppErrorHandler, String>> addSongs({
    required List<AppSongModel> songs,
    required String token,
  });

  //

  Future<Either<AppErrorHandler, List<AppAlbumModel>>> getAllAlbums({
    bool? refetch,
    required String token,
  });

  Future<Either<AppErrorHandler, List<AppArtistModel>>> getAllArtists({
    bool? refetch,
    required String token,
  });

  Future<Either<AppErrorHandler, List<AppSongModel>>> getTodaysMixSongs({
    required String token,
  });

  Future<Either<AppErrorHandler, List<AppSongModel>>> getRecentSongs({
    required String token,
  });

  Future<Either<AppErrorHandler, String>> addRecentSongs({
    required String token,
    List<AppSongModel>? songs,
  });
}

class AudioQueryDataSourceImpl implements IAudioQueryDataSource {
  final AudioQueryLocalDataSource localDataSource;
  final AudioQueryRemoteDataSource remoteDataSource;
  final QueryHiveService queryHiveService;

  AudioQueryDataSourceImpl({
    required this.localDataSource,
    required this.queryHiveService,
    required this.remoteDataSource,
  });
  // Lyrics
  Future<Either<AppErrorHandler, String>> getLyrics({
    required String artist,
    required String title,
    required int songId,
    required String token,
  }) async {
    try {
      final response = await remoteDataSource.getLyrics(
        artist: artist,
        title: title,
        songId: songId,
        token: token,
      );
      return response;
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  // Songs
  @override
  Future<Either<AppErrorHandler, List<AppSongModel>>> getAllSongs({
    required Function(int p1) onProgress,
    bool? first,
    bool? refetch,
    required String token,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      final offline = await get<SettingsHiveService>().getSettings().then(
            (value) => value.offline,
          );
      if (refetch == true) {
        // if both are true then fetch the data from the server and from local storage and compare the data and update the local storage or server accordingly
        if (connectivity && serverUp && !offline) {
          return remoteDataSource.getAllSongs(
            onProgress: onProgress,
            first: first,
            refetch: refetch,
            token: token,
          );
        } else {
          // else return data from the local storage
          return localDataSource.getAllSongs(
            onProgress: onProgress,
            first: first,
            refetch: refetch,
            token: token,
          );
        }
      } else {
        final hiveSongs = await queryHiveService.getAllSongs();
        if (hiveSongs.isNotEmpty) {
          return Right(
            AppSongModel.fromListHiveModel(
              hiveSongs,
            ),
          );
        } else {
          return Left(
            AppErrorHandler(
              message: 'No songs found',
              status: false,
            ),
          );
        }
      }
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, String>> addSong({
    required AppSongModel song,
    required String token,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      final offline = await get<SettingsHiveService>().getSettings().then(
            (value) => value.offline,
          );
      if (connectivity && serverUp && !offline) {
        return remoteDataSource.addSong(
          song: song,
          token: token,
        );
      } else {
        // else return data from the local storage
        return localDataSource.addSong(
          song: song,
          token: token,
        );
      }
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, String>> addSongs({
    required List<AppSongModel> songs,
    required String token,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      final offline = await get<SettingsHiveService>().getSettings().then(
            (value) => value.offline,
          );

      if (connectivity && serverUp && !offline) {
        return remoteDataSource.addSongs(
          songs: songs,
          token: token,
        );
      } else {
        // else return data from the local storage
        return localDataSource.addSongs(
          songs: songs,
          token: token,
        );
      }
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, String>> updateSong({
    required AppSongModel song,
    required String token,
    required bool offline,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();

      // if both are true then fetch the data from the server and from local storage and compare the data and update the local storage or server accordingly
      if (connectivity && serverUp && !offline) {
        return remoteDataSource.updateSong(
          song: song,
          token: token,
          offline: offline,
        );
      } else {
        // else return data from the local storage
        return localDataSource.updateSong(
          song: song,
          token: token,
          offline: offline,
        );
      }
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  //Albums
  @override
  Future<Either<AppErrorHandler, List<AppAlbumModel>>> getAllAlbums({
    bool? refetch,
    required String token,
  }) async {
    try {
      return localDataSource.getAllAlbums(
        refetch: refetch,
        token: token,
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  // Artists
  @override
  Future<Either<AppErrorHandler, List<AppArtistModel>>> getAllArtists({
    bool? refetch,
    required String token,
  }) async {
    try {
      return localDataSource.getAllArtists(
        refetch: refetch,
        token: token,
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, List<AppFolderModel>>> getAllFolders({
    bool? refetch,
    required String token,
  }) async {
    try {
      return localDataSource.getAllFolders(
        refetch: refetch,
        token: token,
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, List<AppSongModel>>> getTodaysMixSongs({
    required String token,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      final offline = await get<SettingsHiveService>().getSettings().then(
            (value) => value.offline,
          );
      // if both are true then fetch the data from the server and from local storage and compare the data and update the local storage or server accordingly
      if (connectivity && serverUp && !offline) {
        return remoteDataSource.getTodaysMixSongs(
          token: token,
        );
      } else {
        // else return data from the local storage
        return const Right([]);
      }
    } catch (e) {
      return const Right([]);
    }
  }

  @override
  Future<Either<AppErrorHandler, List<AppSongModel>>> getRecentSongs(
      {required String token}) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      final offline = await get<SettingsHiveService>().getSettings().then(
            (value) => value.offline,
          );
      // if both are true then fetch the data from the server and from local storage and compare the data and update the local storage or server accordingly
      if (connectivity && serverUp && !offline) {
        final data = await localDataSource.getRecentSongs(
          token: token,
        );
        return data;
      } else {
        // else return data from the local storage
        final data = await localDataSource.getRecentSongs(
          token: token,
        );

        return data;
      }
    } catch (e) {
      return const Right([]);
    }
  }

  @override
  Future<Either<AppErrorHandler, String>> addRecentSongs({
    required String token,
    List<AppSongModel>? songs,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      final offline = await get<SettingsHiveService>().getSettings().then(
            (value) => value.offline,
          );
      // if both are true then fetch the data from the server and from local storage and compare the data and update the local storage or server accordingly
      if (connectivity && serverUp && !offline) {
        // else return data from the local storage
        final data = localDataSource.addRecentSongs(
          token: token,
          songs: songs,
        );

        return await remoteDataSource.addRecentSongs(
          token: token,
          songs: songs,
        );
      } else {
        // else return data from the local storage
        return localDataSource.addRecentSongs(
          token: token,
          songs: songs,
        );
      }
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }
}

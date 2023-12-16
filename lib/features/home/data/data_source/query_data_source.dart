import 'package:dartz/dartz.dart';
import 'package:musync/features/home/data/data_source/local_data_source/local_data_source.dart';

import '../../../../core/failure/error_handler.dart';
import '../../../../core/utils/connectivity_check.dart';
import '../model/app_album_model.dart';
import '../model/app_artist_model.dart';
import '../model/app_folder_model.dart';
import '../model/app_song_model.dart';
import 'local_data_source/hive_service/query_hive_service.dart';

abstract class IAudioQueryDataSource {
  Future<Either<AppErrorHandler, List<AppSongModel>>> getAllSongs({
    required Function(int) onProgress,
    bool? first,
    bool? refetch,
  });

  Future<Either<AppErrorHandler, List<AppAlbumModel>>> getAllAlbums({
    bool? refetch,
  });

  Future<Either<AppErrorHandler, List<AppArtistModel>>> getAllArtists({
    bool? refetch,
  });

  Future<Either<AppErrorHandler, List<AppFolderModel>>> getAllFolders({
    bool? refetch,
  });
}

class AudioQueryDataSourceImpl implements IAudioQueryDataSource {
  final AudioQueryLocalDataSource localDataSource;
  final QueryHiveService queryHiveService;

  AudioQueryDataSourceImpl({
    required this.localDataSource,
    required this.queryHiveService,
  });

  @override
  Future<Either<AppErrorHandler, List<AppAlbumModel>>> getAllAlbums({
    bool? refetch,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      if (refetch == true) {
        // if both are true then fetch the data from the server and from local storage and compare the data and update the local storage or server accordingly
        if (connectivity && serverUp) {
          // !  TODO: here should be remote data source
          return localDataSource.getAllAlbums(
            refetch: refetch,
          );
        } else {
          return localDataSource.getAllAlbums(
            refetch: refetch,
          );
        }
      } else {
        final hiveAlbums = await queryHiveService.getAllAlbums();
        if (hiveAlbums.isNotEmpty) {
          return Right(
            AppAlbumModel.fromListHiveModel(
              hiveAlbums,
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
  Future<Either<AppErrorHandler, List<AppArtistModel>>> getAllArtists({
    bool? refetch,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      if (refetch == true) {
        // if both are true then fetch the data from the server and from local storage and compare the data and update the local storage or server accordingly
        if (connectivity && serverUp) {
          return localDataSource.getAllArtists(
            refetch: refetch,
          );
        } else {
          return localDataSource.getAllArtists(
            refetch: refetch,
          );
        }
      } else {
        final hiveArtists = await queryHiveService.getAllArtists();
        if (hiveArtists.isNotEmpty) {
          return Right(
            AppArtistModel.fromListHiveModel(
              hiveArtists,
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
  Future<Either<AppErrorHandler, List<AppFolderModel>>> getAllFolders({
    bool? refetch,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      if (refetch == true) {
        // if both are true then fetch the data from the server and from local storage and compare the data and update the local storage or server accordingly
        if (connectivity && serverUp) {
          return localDataSource.getAllFolders(refetch: refetch);
        } else {
          return localDataSource.getAllFolders(refetch: refetch);
        }
      } else {
        final hiveFolders = await queryHiveService.getAllFolders();
        if (hiveFolders.isNotEmpty) {
          return Right(
            AppFolderModel.fromListHiveModel(
              hiveFolders,
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
  Future<Either<AppErrorHandler, List<AppSongModel>>> getAllSongs({
    required Function(int p1) onProgress,
    bool? first,
    bool? refetch,
  }) async {
    try {
      // check for the connectivity and server up
      final connectivity = await ConnectivityCheck.connectivity();
      final serverUp = await ConnectivityCheck.isServerup();
      if (refetch == true) {
        // if both are true then fetch the data from the server and from local storage and compare the data and update the local storage or server accordingly
        if (connectivity && serverUp) {
          // ! TODO: here should be remote data source
          return localDataSource.getAllSongs(
            onProgress: onProgress,
            first: first,
            refetch: refetch,
          );
        } else {
          // else return data from the local storage
          final hiveSongs = await queryHiveService.getAllSongs();
          if (hiveSongs.isNotEmpty) {
            return Right(
              AppSongModel.fromListHiveModel(
                hiveSongs,
              ),
            );
          } else {
            return localDataSource.getAllSongs(
              onProgress: onProgress,
              first: first,
              refetch: refetch,
            );
          }
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
}

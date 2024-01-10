import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/data/data_source/query_data_source.dart';
import 'package:musync/features/home/data/model/app_album_model.dart';
import 'package:musync/features/home/data/model/app_artist_model.dart';
import 'package:musync/features/home/data/model/app_folder_model.dart';
import 'package:musync/features/home/data/model/app_song_model.dart';

class AudioQueryRemoteDataSource implements IAudioQueryDataSource {
  final Api api;

  AudioQueryRemoteDataSource({
    required this.api,
  });

  // Songs
  @override
  Future<Either<AppErrorHandler, List<AppSongModel>>> getAllSongs({
    required Function(int p1) onProgress,
    bool? first,
    bool? refetch,
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.get(
        ApiEndpoints.getAllSongsRoute,
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        final List<AppSongModel> allSongs =
            AppSongModel.fromMapList(response.data['songs']);

        return Right(allSongs);
      } else {
        return Left(
          AppErrorHandler(
            message: response.data['message'],
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
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
      final response = await api.sendRequest.post(
        ApiEndpoints.addSongRoute,
        data: song.toMap(),
      );

      if (response.statusCode == 200) {
        return const Right(
          'Song Added',
        );
      } else {
        return Left(
          AppErrorHandler(
            message: response.data['message'],
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
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
      final response = await api.sendRequest.post(
        ApiEndpoints.addSongRoute,
        data: songs.map((song) => song.toMap()).toList(),
      );

      if (response.statusCode == 200) {
        return Right(
          response.data['message'],
        );
      } else {
        return Left(
          AppErrorHandler(
            message: response.data['message'],
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
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
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.updateSongRoute,
        data: {
          "song_id": song.id,
          'songMap': song.toMap(),
        },
      );

      if (response.statusCode == 200) {
        return Right(
          response.data['message'],
        );
      } else {
        return Left(
          AppErrorHandler(
            message: response.data['message'],
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
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
  Future<Either<AppErrorHandler, List<AppAlbumModel>>> getAllAlbums({
    bool? refetch,
    required String token,
  }) async {
    try {
      // Not implemented
      return Left(
        AppErrorHandler(
          message: 'Not implemented',
          status: false,
        ),
      );
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
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
    required String token,
  }) async {
    try {
      // Not implemented
      return Left(
        AppErrorHandler(
          message: 'Not implemented',
          status: false,
        ),
      );
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
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
    required String token,
  }) async {
    try {
      // Not implemented
      return Left(
        AppErrorHandler(
          message: 'Not implemented',
          status: false,
        ),
      );
    } on DioError catch (e) {
      return Left(AppErrorHandler.fromDioError(e));
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

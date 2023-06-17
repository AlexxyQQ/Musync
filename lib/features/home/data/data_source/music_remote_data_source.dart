import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/core/utils/device_info.dart';
import 'package:musync/features/home/data/data_source/music_data_source.dart';
import 'package:musync/features/home/data/data_source/music_hive_data_source.dart';
import 'package:musync/features/home/data/model/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class MusicRemoteDataSource implements AMusicDataSource {
  final Api api;

  const MusicRemoteDataSource({required this.api});

  @override
  Future<Either<ErrorModel, bool>> addAlbums() {
    // TODO: implement addAlbums
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, bool>> addFolders() {
    // TODO: implement addFolders
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, bool>> addAllSongs({
    required List<SongEntity> songs,
    required String token,
  }) async {
    try {
      final Either<ErrorModel, List<SongEntity>> fetchedSongs =
          await getAllSongs(token: token);

      final device = await GetDeviceInfo.deviceInfoPlugin.androidInfo;
      final model = device.model;

      List<SongEntity> filteredSongs = [];

      for (var song in songs) {
        // Check if the song already exists in fetchedSongs
        bool isDuplicate = fetchedSongs.isRight() &&
            fetchedSongs.fold(
              (l) => false,
              (r) => r.any(
                (fetchedSong) =>
                    fetchedSong.data == song.data &&
                    fetchedSong.displayName == song.displayName,
              ),
            );

        if (!isDuplicate) {
          filteredSongs.add(song);
        }
      }

      for (var song in filteredSongs) {
        // Create a FormData object
        final formData = FormData.fromMap({
          'mainFolder': '$model/Music',
          'subFolder': song.data,
          'songModelMap': song.toMap(),
          'files': await MultipartFile.fromFile(
            song.data,
            filename: song.displayName,
          ),
        });
        // Make a multipart request
        final response = await api.sendRequest.post(
          '/music/addAllSongs',
          data: formData,
          options: Options(
            headers: {
              "Authorization": 'Bearer ${token}',
            },
          ),
        );
        ApiResponse apiResponse = ApiResponse.fromResponse(response);

        if (!apiResponse.success) {
          throw Exception(apiResponse.message.toString());
        }
      }
      return const Right(true); // Return success indication
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          ApiResponse responseApi = ApiResponse.fromResponse(e.response!);
          return Left(
            ErrorModel(
              message: responseApi.message.toString(),
              status: false,
            ),
          );
        } else {
          return Left(
            ErrorModel(
              message: 'Network error occurred.',
              status: false,
            ),
          );
        }
      } else {
        return Left(
          ErrorModel(message: 'An unexpected error occurred.', status: false),
        );
      }
    }
  }

  @override
  Future<Either<ErrorModel, bool>> addToPlaylist(
      {required int playlistId, required int audioId}) {
    // TODO: implement addToPlaylist
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, bool>> createPlaylist(
      {required String playlistName}) {
    // TODO: implement createPlaylist
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllAlbumWithSongs() {
    // TODO: implement getAllAlbumWithSongs
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, List<AlbumEntity>>> getAllAlbums() {
    // TODO: implement getAllAlbums
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllArtistWithSongs() {
    // TODO: implement getAllArtistWithSongs
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllFolderWithSongs() {
    // TODO: implement getAllFolderWithSongs
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, List<String>>> getAllFolders() {
    // TODO: implement getAllFolders
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, List<SongEntity>>> getAllSongs({
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.get(
        '/music/getAllSongs',
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (apiResponse.success) {
        final List<SongEntity> songs = [];
        if (songs != []) {
          for (var song in apiResponse.data) {
            songs.add(SongEntity.fromApiMap(song));
          }
          await GetIt.instance<MusicHiveDataSourse>().addAllSongs(
            SongHiveModel.empty().toHiveList(songs),
          );
          await GetIt.instance<MusicHiveDataSourse>().getAllSongs();
        }

        return Right(songs); // Wrap songs list in Right and return
      } else {
        throw Exception(apiResponse.message.toString());
      }
    } on DioException catch (e) {
      if (e.response != null) {
        ApiResponse responseApi = ApiResponse.fromResponse(e.response!);
        return Left(
          ErrorModel(
            message: responseApi.message.toString(),
            status: false,
          ),
        ); // Wrap error message in Left and return
      } else {
        return Left(
          ErrorModel(
            message: 'Network error occurred.',
            status: false,
          ),
        ); // Wrap network error message in Left and return
      }
    } catch (e) {
      return Left(
        ErrorModel(
          message: 'An unexpected error occurred.',
          status: false,
        ),
      ); // Wrap generic error message in Left and return
    }
  }

  @override
  Future<Either<ErrorModel, List<SongEntity>>> getFolderSongs(
      {required String path}) {
    // TODO: implement getFolderSongs
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, List<PlaylistEntity>>> getPlaylists() {
    // TODO: implement getPlaylists
    throw UnimplementedError();
  }

  // @override
  // Future<void> addSongs({
  //   required List<SongEntity> songs,
  //   String? token,
  // }) async {
  //   try {
  //     for (var song in songs) {
  //       // Create a FormData object
  //       final formData = FormData.fromMap({
  //         'mainFolder': 'Music',
  //         'subFolder': song.data,
  //         'songModelMap': song.toMap(),
  //         'files': await MultipartFile.fromFile(
  //           song.data,
  //           filename: song.displayName,
  //         ),
  //       });
  //       // Make a multipart request
  //       final response = await api.sendRequest.post(
  //         '/music/upload',
  //         data: formData,
  //         options: Options(
  //           headers: {
  //             "Authorization": 'Bearer ${token!}',
  //           },
  //         ),
  //       );
  //       ApiResponse apiResponse = ApiResponse.fromResponse(response);

  //       if (apiResponse.success) {
  //       } else {
  //         throw Exception(apiResponse.message.toString());
  //       }
  //     }
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       ApiResponse responseApi = ApiResponse.fromResponse(e.response!);
  //       throw Exception(responseApi.message.toString());
  //     } else {
  //       throw ('Network error occurred.');
  //     }
  //   } catch (e) {
  //     throw ('An unexpected error occurred.');
  //   }
  // }

  // @override
  // Future<List<SongEntity>> getAllSongs({String? token}) async {
  //   try {
  //     final response = await api.sendRequest.get(
  //       '/music/files',
  //       options: Options(
  //         headers: {
  //           "Authorization": 'Bearer $token',
  //         },
  //       ),
  //     );

  //     ApiResponse apiResponse = ApiResponse.fromResponse(response);
  //     if (apiResponse.success) {
  //       final List<SongEntity> songs = [];
  //       for (var song in apiResponse.data) {
  //         songs.add(SongEntity.fromApiMap(song));
  //       }
  //       await GetIt.instance<MusicHiveDataSourse>().addAllSongs(
  //         SongHiveModel.empty().toHiveList(songs),
  //       );
  //       await GetIt.instance<MusicHiveDataSourse>().getAllSongs();

  //       return songs;
  //     } else {
  //       throw Exception(apiResponse.message.toString());
  //     }
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       ApiResponse responseApi = ApiResponse.fromResponse(e.response!);
  //       throw Exception(responseApi.message.toString());
  //     } else {
  //       throw ('Network error occurred.');
  //     }
  //   } catch (e) {
  //     throw ('An unexpected error occurred.');
  //   }
  // }
}

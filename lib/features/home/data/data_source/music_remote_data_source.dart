import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/core/utils/device_info.dart';
import 'package:musync/features/home/data/data_source/i_music_data_source.dart';
import 'package:musync/features/home/data/data_source/music_hive_data_source.dart';
import 'package:musync/features/home/data/data_source/music_local_data_source.dart';
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
    required String token,
    List<SongHiveModel>? songs,
  }) async {
    try {
      /// This code is calling the `getAllSongs` method from the `MusicLocalDataSource` class to get a
      /// list of local songs. The method returns an `Either` object that can contain either an
      /// `ErrorModel` or a list of `SongEntity`. The `fold` method is then used to extract the list of
      /// songs from the `Either` object. If the `Either` object contains an `ErrorModel`, an empty list
      /// is returned, otherwise the list of songs is returned.
      Either<ErrorModel, List<SongEntity>> localSongsEither =
          await GetIt.instance<MusicLocalDataSource>()
              .getAllSongs(token: token);
      final List<SongEntity> localSongs = localSongsEither.fold(
        (l) => [],
        (r) => r,
      );

      final Either<ErrorModel, List<SongEntity>> apiSongsEither =
          await getAllSongs(token: token);
      final List<SongEntity> apiSongs = apiSongsEither.fold(
        (l) => [],
        (r) => r,
      );

      final device = await GetDeviceInfo.deviceInfoPlugin.androidInfo;
      final model = device.model;

      List<SongEntity> filteredSongs = [];

      for (var song in localSongs) {
        bool found = false;

        for (var apiSong in apiSongs) {
          if (song.id == apiSong.id) {
            found = true;
            break;
          }
        }

        if (!found) {
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
        final songResponse = await api.sendRequest.post(
          ApiEndpoints.addAllSongsRoute,
          data: formData,
          options: Options(
            headers: {
              "Authorization": 'Bearer $token',
            },
          ),
        );

        ApiResponse apiSongResponse = ApiResponse.fromResponse(songResponse);

        if (!apiSongResponse.success) {
          throw Exception(apiSongResponse.message.toString());
        } else {
          if (song.albumArt != '') {
            final List<String> musicPath = song.data.split('/');
            final List<String> albumArtPath = song.albumArt.split('/');
            musicPath[musicPath.length - 1] =
                albumArtPath[albumArtPath.length - 1];
            final String newPath = musicPath.join('/');

            final albumformData = FormData.fromMap({
              'mainFolder': '$model/Music',
              'subFolder': newPath,
              'albumArtUP': await MultipartFile.fromFile(
                song.albumArt,
                filename: '${song.displayNameWOExt}.png',
              ),
            });
            await api.sendRequest.post(
              ApiEndpoints.uploadAlbumArtRoute,
              data: albumformData,
              options: Options(
                headers: {
                  "Authorization": 'Bearer $token',
                },
              ),
            );
          }
        }
      }
      return const Right(true); // Return success indication
    } catch (e) {
      if (e is DioError) {
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
      log("Getting all songs from API");
      final response = await api.sendRequest.get(
        ApiEndpoints.getAllSongsRoute,
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (apiResponse.success) {
        final List<dynamic> responseData = apiResponse.data;
        if (responseData.isNotEmpty) {
          final List<SongEntity> apiSongs =
              responseData.map((e) => SongEntity.fromApiMap(e)).toList();
          return Right(apiSongs); // Wrap songs list in Right and return
        } else {
          return const Right([]);
        }
      } else {
        throw Exception(apiResponse.message.toString());
      }
    } on DioError catch (e) {
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
  //   } on DioError catch (e) {
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
  //   } on DioError catch (e) {
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

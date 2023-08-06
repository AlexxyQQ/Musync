import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/core/utils/device_info.dart';
import 'package:musync/features/home/data/data_source/i_music_data_source.dart';
import 'package:musync/features/home/data/data_source/music_local_data_source.dart';
import 'package:musync/features/home/data/model/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class MusicRemoteDataSource implements AMusicDataSource {
  final Api api;

  const MusicRemoteDataSource({required this.api});

// ----- Album -----
  @override
  Future<Either<ErrorModel, bool>> addAlbums({
    required String token,
  }) {
    // TODO: implement addAlbums
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllAlbumWithSongs({
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.get(
        ApiEndpoints.getAllAlbumWithSongsRoute,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw Exception(apiResponse.message.toString());
      } else {
        final Map<String, dynamic> data = apiResponse.data;
        final Map<String, List<SongEntity>> albumWithSongs = {};

        for (var key in data.keys) {
          final List<SongEntity> songs = [];
          for (var song in data[key]) {
            songs.add(
              SongEntity.fromApiMap(
                song,
              ),
            );
          }
          albumWithSongs[key] = songs;
        }

        return Right(albumWithSongs);
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
  Future<Either<ErrorModel, List<AlbumEntity>>> getAllAlbums({
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.get(
        ApiEndpoints.getAllAlbumsRoute,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        return Left(
          ErrorModel(
            message: apiResponse.message.toString(),
            status: false,
          ),
        );
      } else {
        final List<AlbumEntity> albums = [];

        for (var album in apiResponse.data) {
          albums.add(
            AlbumEntity.fromMap(album),
          );
        }

        return Right(albums);
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

//  ----- All Songs -----

  Future<Either<ErrorModel, bool>> addListOfSongs({
    required String token,
    required List<SongEntity> songs,
    bool isPublic = false,
  }) async {
    try {
      final Either<ErrorModel, List<SongEntity>> apiSongsEither =
          await getAllSongs(token: token);
      final List<SongEntity> apiSongs = apiSongsEither.fold(
        (l) => [],
        (r) => r,
      );

      final device = await GetDeviceInfo.deviceInfoPlugin.androidInfo;
      final model = device.model;

      List<SongEntity> filteredSongs = [];

      for (var song in songs) {
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
        final updatedSongModelMap = Map<String, dynamic>.from(song.toMap());

        updatedSongModelMap['isPublic'] = isPublic;


        final formData = FormData.fromMap({
          'mainFolder': '$model/Music',
          'subFolder': song.data,
          'songModelMap': updatedSongModelMap,
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
          continue;
        } else {
          if (song.albumArt != '') {
            final List<String> musicPath = song.data.split('/');
            musicPath[musicPath.length - 1] = "${song.id}.png";
            final String newPath = musicPath.join('/');

            final albumformData = FormData.fromMap({
              'mainFolder': '$model/Music',
              'subFolder': newPath,
              'albumArtUP': await MultipartFile.fromFile(
                song.albumArt,
                filename: '${song.id}.png',
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
  Future<Either<ErrorModel, bool>> addAllSongs({
    required String token,
    List<SongHiveModel>? songs,
  }) async {
    try {
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
          continue;
        } else {
          if (song.albumArt != '') {
            final List<String> musicPath = song.data.split('/');
            musicPath[musicPath.length - 1] = "${song.id}.png";
            final String newPath = musicPath.join('/');

            final albumformData = FormData.fromMap({
              'mainFolder': '$model/Music',
              'subFolder': newPath,
              'albumArtUP': await MultipartFile.fromFile(
                song.albumArt,
                filename: '${song.id}.png',
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
  Future<Either<ErrorModel, List<SongEntity>>> getAllSongs({
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

// ----- Folder -----

  @override
  Future<Either<ErrorModel, List<String>>> getAllFolders({
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.get(
        ApiEndpoints.getAllFoldersRoute,
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
          final List<String> apiFolders =
              responseData.map((e) => e.toString()).toList();
          return Right(apiFolders); // Wrap folders list in Right and return
        } else {
          return const Right([]);
        }
      } else {
        return Left(
          ErrorModel(
            message: apiResponse.message.toString(),
            status: false,
          ),
        );
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
      getAllFolderWithSongs({required String token}) async {
    try {
      final response = api.sendRequest.get(
        ApiEndpoints.getAllFolderWithSongsRoute,
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(await response);

      if (apiResponse.success) {
        final Map<String, dynamic> responseData = apiResponse.data;
        if (responseData.isNotEmpty) {
          final Map<String, List<SongEntity>> apiFolders = {};
          responseData.forEach((key, value) {
            apiFolders[key] =
                value.map<SongEntity>((e) => SongEntity.fromApiMap(e)).toList();
          });
          return Right(apiFolders); // Wrap folders list in Right and return
        } else {
          return const Right({});
        }
      } else {
        return Left(
          ErrorModel(
            message: apiResponse.message.toString(),
            status: false,
          ),
        );
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
  Future<Either<ErrorModel, List<SongEntity>>> getFolderSongs({
    required String path,
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.getFolderSongsRoute,
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
        data: {
          "folderUrl": path,
        },
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
        return Left(
          ErrorModel(
            message: apiResponse.message.toString(),
            status: false,
          ),
        );
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
  Future<Either<ErrorModel, bool>> addFolders({
    required String token,
  }) {
    // TODO: implement addFolders
    throw UnimplementedError();
  }

// ----- Artist -----

  @override
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllArtistWithSongs({
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.get(
        ApiEndpoints.getAllArtistWithSongsRoute,
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        final Map<String, dynamic> responseData = apiResponse.data;
        if (responseData.isNotEmpty) {
          final Map<String, List<SongEntity>> apiArtists = {};
          responseData.forEach((key, value) {
            apiArtists[key] =
                value.map<SongEntity>((e) => SongEntity.fromApiMap(e)).toList();
          });
          return Right(apiArtists); // Wrap artists list in Right and return
        } else {
          return const Right({});
        }
      } else {
        return Left(
          ErrorModel(
            message: apiResponse.message.toString(),
            status: false,
          ),
        );
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

  // ----- Playlist -----

  @override
  Future<Either<ErrorModel, bool>> addToPlaylist({
    required int playlistId,
    required int audioId,
    required String token,
  }) {
    // TODO: implement addToPlaylist
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, bool>> createPlaylist({
    required String playlistName,
    required String token,
  }) {
    // TODO: implement createPlaylist
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, List<PlaylistEntity>>> getPlaylists({
    required String token,
  }) {
    // TODO: implement getPlaylists
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorModel, bool>> tooglePublic({
    required int songID,
    required String token,
    required bool isPublic,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.toogleSongPublicRoute,
        data: {
          "songId": songID,
          'toggleValue': isPublic,
        },
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (apiResponse.success) {
        return Right(isPublic);
      } else {
        return Left(
          ErrorModel(
            message: apiResponse.message.toString(),
            status: false,
          ),
        );
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
  Future<Either<ErrorModel, List<SongEntity>>> getAllPublicSongs() async {
    try {
      final response = await api.sendRequest.get(
        ApiEndpoints.getAllPublicSongsRoute,
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
        return Left(
          ErrorModel(
            message: apiResponse.message.toString(),
            status: false,
          ),
        );
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
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/network/api/api.dart';
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
  Future<void> addAlbums() {
    // TODO: implement addAlbums
    throw UnimplementedError();
  }

  @override
  Future<void> addFolders() {
    // TODO: implement addFolders
    throw UnimplementedError();
  }

  @override
  Future<void> addSongs({
    required List<SongEntity> songs,
    String? token,
  }) async {
    try {
      for (var song in songs) {
        // Create a FormData object
        final formData = FormData.fromMap({
          'mainFolder': 'Music',
          'subFolder': song.data,
          'songModelMap': song.toMap(),
          'files': await MultipartFile.fromFile(
            song.data,
            filename: song.displayName,
          ),
        });
        // Make a multipart request
        final response = await api.sendRequest.post(
          '/music/upload',
          data: formData,
          options: Options(
            headers: {
              "Authorization": 'Bearer ${token!}',
            },
          ),
        );
        ApiResponse apiResponse = ApiResponse.fromResponse(response);

        if (apiResponse.success) {
        } else {
          throw Exception(apiResponse.message.toString());
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        ApiResponse responseApi = ApiResponse.fromResponse(e.response!);
        throw Exception(responseApi.message.toString());
      } else {
        throw ('Network error occurred.');
      }
    } catch (e) {
      throw ('An unexpected error occurred.');
    }
  }

  @override
  Future<void> addToPlaylist({required int playlistId, required int audioId}) {
    // TODO: implement addToPlaylist
    throw UnimplementedError();
  }

  @override
  Future<void> createPlaylist({required String playlistName}) {
    // TODO: implement createPlaylist
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<SongEntity>>> getAllAlbumWithSongs() {
    // TODO: implement getAllAlbumWithSongs
    throw UnimplementedError();
  }

  @override
  Future<List<AlbumEntity>> getAllAlbums() {
    // TODO: implement getAllAlbums
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<SongEntity>>> getAllArtistWithSongs() {
    // TODO: implement getAllArtistWithSongs
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<SongEntity>>> getAllFolderWithSongs() {
    // TODO: implement getAllFolderWithSongs
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getAllFolders() {
    // TODO: implement getAllFolders
    throw UnimplementedError();
  }

  @override
  Future<List<SongEntity>> getAllSongs({String? token}) async {
    try {
      final response = await api.sendRequest.get(
        '/music/files',
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
          },
        ),
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (apiResponse.success) {
        final List<SongEntity> songs = [];
        for (var song in apiResponse.data) {
          songs.add(SongEntity.fromApiMap(song));
        }
        await GetIt.instance<MusicHiveDataSourse>().addAllSongs(
          SongHiveModel.empty().toHiveList(songs),
        );
        await GetIt.instance<MusicHiveDataSourse>().getAllSongs();

        return songs;
      } else {
        throw Exception(apiResponse.message.toString());
      }
    } on DioException catch (e) {
      if (e.response != null) {
        ApiResponse responseApi = ApiResponse.fromResponse(e.response!);
        throw Exception(responseApi.message.toString());
      } else {
        throw ('Network error occurred.');
      }
    } catch (e) {
      throw ('An unexpected error occurred.');
    }
  }

  @override
  Future<List<SongEntity>> getFolderSongs({required String path}) {
    // TODO: implement getFolderSongs
    throw UnimplementedError();
  }

  @override
  Future<List<PlaylistEntity>> getPlaylists() {
    // TODO: implement getPlaylists
    throw UnimplementedError();
  }
}

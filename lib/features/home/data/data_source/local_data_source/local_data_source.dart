import 'package:dartz/dartz.dart';
import 'package:musync/core/common/album_art_query_save.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/data/data_source/local_data_source/hive_service/query_hive_service.dart';
import 'package:musync/features/home/data/data_source/query_data_source.dart';
import 'package:musync/features/home/data/model/app_album_model.dart';
import 'package:musync/features/home/data/model/app_artist_model.dart';
import 'package:musync/features/home/data/model/app_folder_model.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';
import 'package:musync/injection/app_injection_container.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../../core/utils/song_model_map_converter.dart';
import '../../model/app_song_model.dart';

class AudioQueryLocalDataSource implements IAudioQueryDataSource {
  final OnAudioQuery onAudioQuery;

  AudioQueryLocalDataSource({
    required this.onAudioQuery,
  });

  // Songs
  @override
  Future<Either<AppErrorHandler, List<AppSongModel>>> getAllSongs({
    required Function(int) onProgress,
    bool? first,
    bool? refetch,
    required String token,
  }) async {
    try {
      final List<SongModel> allQuerySongs = await onAudioQuery.querySongs(
        sortType: SongSortType.ALBUM,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      if (first == false) {
        final List<AppSongModel> fetchedSongs = [];
        // get album art for all songs
        for (var song in allQuerySongs) {
          final artworkPath =
              await AlbumArtQuerySave(audioQuery: onAudioQuery).saveAlbumArt(
            id: song.id,
            type: ArtworkType.AUDIO,
            fileName: song.displayNameWOExt,
          );

          final Map<String, dynamic> songMap = convertMap(
            song.getMap,
          );

          songMap.addAll(
            {
              'album_art': artworkPath,
            },
          );

          fetchedSongs.add(
            AppSongModel.fromModelMap(songMap),
          );
        }

        return Right(
          fetchedSongs,
        );
      }

      List<AppSongModel> fetchedSongs = [];

      for (var song in allQuerySongs) {
        final artworkPath =
            await AlbumArtQuerySave(audioQuery: onAudioQuery).saveAlbumArt(
          id: song.id,
          type: ArtworkType.AUDIO,
          fileName: song.displayNameWOExt,
        );

        final Map<String, dynamic> songMap = convertMap(
          song.getMap,
        );

        songMap.addAll(
          {
            'album_art': artworkPath,
          },
        );

        fetchedSongs.add(
          AppSongModel.fromModelMap(songMap),
        );
        onProgress(fetchedSongs.length);
        await Future.delayed(
          const Duration(
            milliseconds: 1,
          ),
        );
      }
      return Right(fetchedSongs);
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
      final queryHiveService = get<QueryHiveService>();

      final hiveSong = song.toHiveModel();

      await queryHiveService.updateSong(
        hiveSong,
      );

      return const Right(
        'Song Updated',
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
  Future<Either<AppErrorHandler, String>> addSong({
    required AppSongModel song,
    required String token,
  }) async {
    try {
      final queryHiveService = get<QueryHiveService>();

      final hiveSong = song.toHiveModel();

      await queryHiveService.addSong(
        hiveSong,
      );

      return const Right(
        'Song Added',
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
  Future<Either<AppErrorHandler, String>> addSongs({
    required List<AppSongModel> songs,
    required String token,
  }) async {
    try {
      final queryHiveService = get<QueryHiveService>();

      final hiveSongs = songs.map((e) => e.toHiveModel()).toList();

      await queryHiveService.addSongs(
        hiveSongs,
      );

      return const Right(
        'Songs Added',
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

  // Get All Albums
  @override
  Future<Either<AppErrorHandler, List<AppAlbumModel>>> getAllAlbums({
    bool? refetch,
    required String token,
  }) async {
    try {
      final List<AlbumModel> allQueryAlbums = await onAudioQuery.queryAlbums(
        sortType: AlbumSortType.ALBUM,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      // ! TODO: Need to add songs in album in cubit
      return Right(
        AppAlbumModel.fromListAlbumModle(
          allQueryAlbums,
        ),
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

  // Get All Artists
  @override
  Future<Either<AppErrorHandler, List<AppArtistModel>>> getAllArtists({
    bool? refetch,
    required String token,
  }) async {
    try {
      final List<ArtistModel> allQueryArtists = await onAudioQuery.queryArtists(
        sortType: ArtistSortType.ARTIST,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
      // ! TODO: Need to add songs in artist in cubit
      return Right(
        AppArtistModel.fromListAlbumModle(
          allQueryArtists,
        ),
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
  Future<Either<AppErrorHandler, List<AppFolderModel>>> getAllFolders({
    bool? refetch,
    required String token,
  }) async {
    try {
      final List<String> allQueryFolders = await onAudioQuery.queryAllPath();
      // ! TODO: Need to add songs and number of songs in folder in cubit
      return Right(
        AppFolderModel.fromListofPaths(
          allQueryFolders,
        ),
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
  Future<Either<AppErrorHandler, List<AppSongModel>>> getTodaysMixSongs(
      {required Function(int p1) onProgress,
      bool? first,
      bool? refetch,
      required String token}) async {
    return const Right([]);
  }

  @override
  Future<Either<AppErrorHandler, String>> addRecentSongs(
      {required String token, List<AppSongModel>? songs}) async {
    try {
      final queryHiveService = get<QueryHiveService>();

      final hiveSongs = songs?.map((e) => e.toHiveModel()).toList() ?? [];

      await queryHiveService.addRecentSongs(
        hiveSongs,
      );

      return const Right(
        'Songs Added',
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
  Future<Either<AppErrorHandler, List<AppSongModel>>> getRecentSongs({
    required String token,
  }) async {
    try {
      final queryHiveService = get<QueryHiveService>();

      final List<SongHiveModel> hiveRecentSongs =
          await queryHiveService.getAllRecentSongs();

      final List<AppSongModel> recentSongs =
          AppSongModel.fromListHiveModel(hiveRecentSongs);

      return Right(recentSongs);
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

import 'package:dartz/dartz.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/artist_entity.dart';
import 'package:musync/features/home/domain/entity/folder_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

import '../../../../core/failure/error_handler.dart';

abstract class IAudioQueryRepository {
  Future<Either<AppErrorHandler, String>> getLyrics({
    required String artist,
    required String title,
    required int songId,
    required String token,
  });
  Future<Either<AppErrorHandler, List<SongEntity>>> getAllSongs({
    required Function(int) onProgress,
    bool? first,
    bool? refetch,
    required String token,
  });
  Future<Either<AppErrorHandler, List<AlbumEntity>>> getAllAlbums({
    bool? refetch,
    required String token,
  });

  Future<Either<AppErrorHandler, List<ArtistEntity>>> getAllArtists({
    bool? refetch,
    required String token,
  });

  Future<Either<AppErrorHandler, List<FolderEntity>>> getAllFolders({
    bool? refetch,
    required String token,
  });

  Future<Either<AppErrorHandler, String>> updateSong({
    required SongEntity song,
    required String token,
    required bool offline,
  });

  Future<Either<AppErrorHandler, List<SongEntity>>> getTodaysMixSongs({
    required String token,
  });

  Future<Either<AppErrorHandler, String>> addRecentSongs({
    required String token,
    List<SongEntity>? songs,
  });

  Future<Either<AppErrorHandler, List<SongEntity>>> getRecentSongs({
    required String token,
  });
}

import 'package:dartz/dartz.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/artist_entity.dart';
import 'package:musync/features/home/domain/entity/folder_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

import '../../../../core/failure/error_handler.dart';

abstract class IAudioQueryRepository {
  Future<Either<AppErrorHandler, List<SongEntity>>> getAllSongs({
    required Function(int) onProgress,
    bool? first,
  });
  Future<Either<AppErrorHandler, List<AlbumEntity>>> getAllAlbums();

  Future<Either<AppErrorHandler, List<ArtistEntity>>> getAllArtists();

  Future<Either<AppErrorHandler, List<FolderEntity>>> getAllFolders();
}

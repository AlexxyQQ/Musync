import 'package:dartz/dartz.dart';

import '../../../../core/failure/error_handler.dart';
import '../../domain/entity/album_entity.dart';
import '../../domain/entity/artist_entity.dart';
import '../../domain/entity/folder_entity.dart';
import '../../domain/repository/audio_query_repository.dart';
import '../data_source/query_data_source.dart';
import '../model/app_song_model.dart';

class AudioQueryRepositiryImpl implements IAudioQueryRepository {
  final IAudioQueryDataSource audioQueryDataSource;

  AudioQueryRepositiryImpl({
    required this.audioQueryDataSource,
  });

  @override
  Future<Either<AppErrorHandler, List<AppSongModel>>> getAllSongs({
    required Function(int) onProgress,
    bool? first,
    bool? refetch,
  }) async {
    return await audioQueryDataSource.getAllSongs(
      onProgress: onProgress,
      first: first,
      refetch: refetch,
    );
  }

  @override
  Future<Either<AppErrorHandler, List<AlbumEntity>>> getAllAlbums({
    bool? refetch,
  }) async {
    return await audioQueryDataSource.getAllAlbums(
      refetch: refetch,
    );
  }

  @override
  Future<Either<AppErrorHandler, List<ArtistEntity>>> getAllArtists({
    bool? refetch,
  }) async {
    return await audioQueryDataSource.getAllArtists(
      refetch: refetch,
    );
  }

  @override
  Future<Either<AppErrorHandler, List<FolderEntity>>> getAllFolders({
    bool? refetch,
  }) async {
    return await audioQueryDataSource.getAllFolders(
      refetch: refetch,
    );
  }
}

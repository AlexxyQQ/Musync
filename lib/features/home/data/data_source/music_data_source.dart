import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/data/model/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

abstract class AMusicDataSource {
  Future<Either<ErrorModel, bool>> addAllSongs(
      {required String token,  List<SongHiveModel> songs});
  Future<Either<ErrorModel, List<SongEntity>>> getAllSongs({
    required String token,
  });
  Future<Either<ErrorModel, List<SongEntity>>> getFolderSongs({
    required String path,
  });

  Future<Either<ErrorModel, bool>> addAlbums();
  Future<Either<ErrorModel, List<AlbumEntity>>> getAllAlbums();
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllAlbumWithSongs();

  Future<Either<ErrorModel, bool>> addFolders();
  Future<Either<ErrorModel, List<String>>> getAllFolders();
  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllFolderWithSongs();

  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllArtistWithSongs();

  Future<Either<ErrorModel, bool>> createPlaylist({
    required String playlistName,
  });
  Future<Either<ErrorModel, bool>> addToPlaylist({
    required int playlistId,
    required int audioId,
  });

  Future<Either<ErrorModel, List<PlaylistEntity>>> getPlaylists();
}

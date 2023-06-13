import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

abstract class IMusicQueryRepository {
  Future<void> permission();
  Future<List<SongEntity>> getAllSongs();
  Future<List<SongEntity>> getFolderSongs({required String path});
  Future<List<AlbumEntity>> getAllAlbums();
  Future<List<String>> getAllFolders();
  Future<Map<String, List<SongEntity>>> getAllFolderWithSongs();
  Future<Map<String, List<SongEntity>>> getAllAlbumWithSongs();
  Future<Map<String, List<SongEntity>>> getAllArtistWithSongs();
  Future<Map<String, Map<String, List<SongEntity>>>> getEverything();
}

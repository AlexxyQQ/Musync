import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

abstract class AMusicDataSource {
  Future<void> addSongs({
    required List<SongEntity> songs,
    String? token,
  });
  Future<List<SongEntity>> getAllSongs({
    String? token,
  });
  Future<List<SongEntity>> getFolderSongs({required String path});

  Future<void> addAlbums();
  Future<List<AlbumEntity>> getAllAlbums();
  Future<Map<String, List<SongEntity>>> getAllAlbumWithSongs();

  Future<void> addFolders();
  Future<List<String>> getAllFolders();
  Future<Map<String, List<SongEntity>>> getAllFolderWithSongs();

  Future<Map<String, List<SongEntity>>> getAllArtistWithSongs();

  Future<void> createPlaylist({required String playlistName});
  Future<void> addToPlaylist({
    required int playlistId,
    required int audioId,
  });

  Future<List<PlaylistEntity>> getPlaylists();
}

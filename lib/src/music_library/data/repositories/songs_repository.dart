import 'package:on_audio_query/on_audio_query.dart';

abstract class SongsRepository {
  Future<List<SongModel>> getAllSongsNoFilter({bool recheck = false});
  Future<List<SongModel>> getAllSongsFilter({bool recheck = false});
  Future<List<AlbumModel>> getAlbums({bool recheck = false});
  Future<List<SongModel>> getArtistSongs({bool recheck = false});
  Future<List<String>> getFolders({bool recheck = false});
  Future<List<SongModel>> getFolderSong({
    bool recheck = false,
    required String path,
  });
  Future<String> saveAlbumArt({
    required int id,
    required ArtworkType type,
    required String fileName,
    int size = 200,
    int quality = 100,
    ArtworkFormat format = ArtworkFormat.PNG,
  });
}

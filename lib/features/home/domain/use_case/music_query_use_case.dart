import 'package:musync/features/home/data/repository/music_query_repositories.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class MusicQueryUseCase {
  final MusicQueryRepositoryImpl musicQueryRepository;
  const MusicQueryUseCase({required this.musicQueryRepository});

  Future<void> permission() async {
    try {
      await musicQueryRepository.permission();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, List<SongEntity>>> getAllAlbumWithSongs() async {
    try {
      final data = await musicQueryRepository.getAllAlbumWithSongs();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AlbumEntity>> getAllAlbums() async {
    try {
      final data = await musicQueryRepository.getAllAlbums();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, List<SongEntity>>> getAllArtistWithSongs() async {
    try {
      final data = await musicQueryRepository.getAllArtistWithSongs();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, List<SongEntity>>> getAllFolderWithSongs() async {
    try {
      final data = await musicQueryRepository.getAllFolderWithSongs();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getAllFolders() async {
    try {
      final data = await musicQueryRepository.getAllFolders();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SongEntity>> getAllSongs() async {
    try {
      final data = await musicQueryRepository.getAllSongs();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SongEntity>> getFolderSongs({required String path}) async {
    try {
      final data = await musicQueryRepository.getFolderSongs(path: path);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, Map<String, List<SongEntity>>>> getEverything() async {
    try {
      final data = await musicQueryRepository.getEverything();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

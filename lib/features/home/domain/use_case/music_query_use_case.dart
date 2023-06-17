import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/features/home/data/repository/music_query_repositories.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class MusicQueryUseCase {
  final MusicQueryRepositoryImpl musicQueryRepository;
  const MusicQueryUseCase({required this.musicQueryRepository});

  // Future<void> permission() async {
  //   try {
  //     await musicQueryRepository.permission();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<Map<String, List<SongEntity>>> getAllAlbumWithSongs() async {
  //   try {
  //     final data = await musicQueryRepository.getAllAlbumWithSongs();
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<AlbumEntity>> getAllAlbums() async {
  //   try {
  //     final data = await musicQueryRepository.getAllAlbums();
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<Map<String, List<SongEntity>>> getAllArtistWithSongs() async {
  //   try {
  //     final data = await musicQueryRepository.getAllArtistWithSongs();
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<Map<String, List<SongEntity>>> getAllFolderWithSongs() async {
  //   try {
  //     final data = await musicQueryRepository.getAllFolderWithSongs();
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<String>> getAllFolders() async {
  //   try {
  //     final data = await musicQueryRepository.getAllFolders();
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<SongEntity>> getAllSongs() async {
  //   try {
  //     final data = await musicQueryRepository.getAllSongs();
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<SongEntity>> getFolderSongs({required String path}) async {
  //   try {
  //     final data = await musicQueryRepository.getFolderSongs(path: path);
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<Map<String, Map<String, List<SongEntity>>>> getEverything() async {
  //   try {
  //     final data = await musicQueryRepository.getEverything();
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> createPlaylist({required String playlistName}) async {
  //   try {
  //     await musicQueryRepository.createPlaylist(playlistName: playlistName);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<PlaylistEntity>> getAllPlaylist() async {
  //   try {
  //     final data = await musicQueryRepository.getAllPlaylists();
  //     return data;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllAlbumWithSongs() async {
    final data = await musicQueryRepository.getAllAlbumWithSongs();
    return data;
  }

  Future<Either<ErrorModel, List<AlbumEntity>>> getAllAlbums() async {
    final data = await musicQueryRepository.getAllAlbums();
    return data;
  }

  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllArtistWithSongs() async {
    final data = await musicQueryRepository.getAllArtistWithSongs();
    return data;
  }

  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllFolderWithSongs() async {
    final data = await musicQueryRepository.getAllFolderWithSongs();
    return data;
  }

  Future<Either<ErrorModel, List<String>>> getAllFolders() async {
    final data = await musicQueryRepository.getAllFolders();
    return data;
  }

  Future<Either<ErrorModel, List<SongEntity>>> getAllSongs({
    required String token,
  }) async {
    final data = await musicQueryRepository.getAllSongs(token: token);
    return data;
  }

  Future<Either<ErrorModel, List<SongEntity>>> getFolderSongs({
    required String path,
  }) async {
    final data = await musicQueryRepository.getFolderSongs(path: path);
    return data;
  }

  Future<Either<ErrorModel, bool>> permission() async {
    return await musicQueryRepository.permission();
  }

  Future<Either<ErrorModel, Map<String, Map<String, List<SongEntity>>>>>
      getEverything() async {
    final data = await musicQueryRepository.getEverything();
    return data;
  }

  Future<Either<ErrorModel, List<PlaylistEntity>>> getAllPlaylists() async {
    final data = await musicQueryRepository.getAllPlaylists();
    return data;
  }

  Future<Either<ErrorModel, bool>> createPlaylist({
    required String playlistName,
  }) async {
    return await musicQueryRepository.createPlaylist(
      playlistName: playlistName,
    );
  }

  Future<Either<ErrorModel, bool>> addAllSongs({
    required List<SongEntity> songs,
    required String token,
  }) async {
    return await musicQueryRepository.addAllSongs(songs: songs, token: token);
  }
}

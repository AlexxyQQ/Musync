import 'package:dartz/dartz.dart';
import 'package:musync/core/failure/error_handler.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/home/data/repository/music_query_repositories.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class MusicQueryUseCase {
  final MusicQueryRepositoryImpl musicQueryRepository;
  final HiveQueries hiveQueries;
  const MusicQueryUseCase({
    required this.musicQueryRepository,
    required this.hiveQueries,
  });

  Future<Either<ErrorModel, bool>> permission() async {
    return await musicQueryRepository.permission();
  }

  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllAlbumWithSongs() async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    final data = await musicQueryRepository.getAllAlbumWithSongs(token: token);
    return data;
  }

  Future<Either<ErrorModel, List<AlbumEntity>>> getAllAlbums() async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    final data = await musicQueryRepository.getAllAlbums(token: token);
    return data;
  }

  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllArtistWithSongs() async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    final data = await musicQueryRepository.getAllArtistWithSongs(token: token);
    return data;
  }

  Future<Either<ErrorModel, Map<String, List<SongEntity>>>>
      getAllFolderWithSongs() async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    final data = await musicQueryRepository.getAllFolderWithSongs(token: token);
    return data;
  }

  Future<Either<ErrorModel, List<String>>> getAllFolders() async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    final data = await musicQueryRepository.getAllFolders(token: token);
    return data;
  }

  Future<Either<ErrorModel, List<SongEntity>>> getAllSongs() async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    final data = await musicQueryRepository.getAllSongs(token: token);
    return data;
  }

  Future<Either<ErrorModel, List<SongEntity>>> getFolderSongs({
    required String path,
  }) async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    final data =
        await musicQueryRepository.getFolderSongs(path: path, token: token);
    return data;
  }

  Future<Either<ErrorModel, Map<String, Map<String, List<SongEntity>>>>>
      getEverything() async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    final data = await musicQueryRepository.getEverything(token: token);
    return data;
  }

  Future<Either<ErrorModel, List<PlaylistEntity>>> getAllPlaylists() async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    final data = await musicQueryRepository.getAllPlaylists(token: token);
    return data;
  }

  Future<Either<ErrorModel, bool>> createPlaylist({
    required String playlistName,
  }) async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    return await musicQueryRepository.createPlaylist(
      token: token,
      playlistName: playlistName,
    );
  }

  Future<Either<ErrorModel, bool>> addAllSongs({
    required String token,
  }) async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    return await musicQueryRepository.addAllSongs(token: token);
  }

  Future<Either<ErrorModel, bool>> addListOfSongs({
    required List<SongEntity> songs,
    bool isPublic = false,
  }) async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    return await musicQueryRepository.addListOfSongs(
      token: token,
      songs: songs,
      isPublic: isPublic,
    );
  }

  Future<Either<ErrorModel, bool>> toggleSongPublic({
    required int songID,
    required bool isPublic,
  }) async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    return await musicQueryRepository.makeSongPublic(
      songID: songID,
      token: token,
      isPublic: isPublic,
    );
  }

  Future<Either<ErrorModel, List<SongEntity>>> getAllPublicSongs() async {
    return await musicQueryRepository.getAllPublicSongs();
  }

  Future<Either<ErrorModel, List<SongEntity>>> getUserPublicSongs() async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    return await musicQueryRepository.getUserPublicSongs(token: token);
  }

  Future<Either<ErrorModel, bool>> deleteSong({
    required int songID,
  }) async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    return musicQueryRepository.deleteSong(songID: songID, token: token);
  }
}

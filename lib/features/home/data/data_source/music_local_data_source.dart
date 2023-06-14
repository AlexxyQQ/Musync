import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/features/home/data/data_source/music_data_source.dart';
import 'package:musync/features/home/data/data_source/music_hive_data_source.dart';
import 'package:musync/features/home/data/model/album_hive_model.dart';
import 'package:musync/features/home/data/model/playlist_hive_model.dart';
import 'package:musync/features/home/data/model/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicLocalDataSource implements AMusicDataSource {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final musicHiveDataSourse = GetIt.instance<MusicHiveDataSourse>();

  @override
  Future<List<SongEntity>> getFolderSongs({required String path}) async {
    // check if music already in hive
    var allHiveFolderSongs =
        await musicHiveDataSourse.getFolderSongs(path: path);
    if (allHiveFolderSongs.isNotEmpty) {
      // return song entity if songs in hive
      var allEntitySongs =
          SongHiveModel.empty().toEntityList(allHiveFolderSongs);
      return allEntitySongs;
    } else {
      final List<SongModel> allQuerySongs = await audioQuery.querySongs(
        path: path,
        sortType: SongSortType.ALBUM,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      // Getting List of SongEntities
      List<SongEntity> songEntityList = [];
      if (allQuerySongs != null) {
        for (var songMap in allQuerySongs) {
          songEntityList.add(
            SongEntity.fromModelMap(
              convertMap(songMap.getMap),
            ),
          );
        }
      }

      return songEntityList;
    }
  }

  /// Get all Albums
  @override
  Future<List<AlbumEntity>> getAllAlbums() async {
    const MethodChannel channel =
        MethodChannel('com.lucasjosino.on_audio_query');

    var allQueryAlbums = await channel.invokeMethod(
      "queryAlbums",
      {
        "albumSortType": AlbumSortType.ALBUM.index,
        "orderType": OrderType.ASC_OR_SMALLER.index,
        "uri": UriType.EXTERNAL.index,
        "ignoreCase": true,
      },
    );
    List<AlbumEntity> albumEntityList = [];
    if (allQueryAlbums != null) {
      for (var albumMap in allQueryAlbums) {
        albumEntityList.add(AlbumEntity.fromMap(convertMap(albumMap)));
      }
    }
    // Converting Entities to Hive
    var albumHiveList = AlbumHiveModel.empty().toHiveList(albumEntityList);
    await musicHiveDataSourse.addAllAlbums(albumHiveList);
    return albumEntityList;
  }

  /// Get all Folders
  @override
  Future<List<String>> getAllFolders() async {
    var allSongFolders = await musicHiveDataSourse.getAllFolders();
    if (allSongFolders.isNotEmpty) {
      return allSongFolders;
    } else {
      final List<String> allSongFolders = await audioQuery.queryAllPath();
      await musicHiveDataSourse.addAllFolders(allSongFolders);
      return allSongFolders;
    }
  }

  @override
  Future<Map<String, List<SongEntity>>> getAllFolderWithSongs() async {
    final Map<String, List<SongEntity>> result = {};
    final List<String> allFolder = await getAllFolders();
    for (String folderPath in allFolder) {
      List<SongEntity> folderSongEntityList =
          await getFolderSongs(path: folderPath);
      result[folderPath] = folderSongEntityList;
    }
    return result;
  }

  @override
  Future<Map<String, List<SongEntity>>> getAllAlbumWithSongs() async {
    final Map<String, List<SongEntity>> result = {};
    final List<AlbumEntity> allAlbums = await getAllAlbums();
    final List<SongEntity> allSongs = await getAllSongs();
    for (AlbumEntity album in allAlbums) {
      final albumSongs = allSongs
          .where(
            (element) => (element.albumId).toString() == album.id,
          )
          .toList();
      result[album.id] = albumSongs;
    }
    return result;
  }

  @override
  Future<Map<String, List<SongEntity>>> getAllArtistWithSongs() async {
    final Map<String, List<SongEntity>> result = {};
    final List<SongEntity> allSongs = await getAllSongs();
    for (SongEntity song in allSongs) {
      final artistSongs = allSongs
          .where(
            (element) => (element.artistId).toString() == song.artistId,
          )
          .toList();
      result[song.artist ?? 'Unknown'] = artistSongs;
    }
    return result;
  }

  @override
  Future<void> createPlaylist({required String playlistName}) async {
    var playlists = await getPlaylists();
    for (var playlist in playlists) {
      if (playlist.playlist != playlistName) {
        await audioQuery.createPlaylist(playlistName);
      }
    }
  }

  @override
  Future<void> addToPlaylist({
    required int playlistId,
    required int audioId,
  }) async {
    await audioQuery.addToPlaylist(playlistId, audioId);
  }

  @override
  Future<List<PlaylistEntity>> getPlaylists() async {
    audioQuery.queryPlaylists();
    // check if music already in hive
    var allHivePlaylists = await musicHiveDataSourse.getAllPlaylist();
    if (allHivePlaylists.isNotEmpty) {
      // return song entity if songs in hive
      var allEntitySongs =
          PlaylistHiveModel.empty().toEntityList(allHivePlaylists);
      return allEntitySongs;
    } else {
      // if song not in hive query song and add it to hive

      final List<PlaylistModel> allQueryPlaylists =
          await audioQuery.queryPlaylists();
      // Getting List of SongEntities
      List<PlaylistEntity> songEntityList = [];
      if (allQueryPlaylists != null) {
        for (var playlist in allQueryPlaylists) {
          songEntityList.add(
            PlaylistEntity.fromMap(
              convertMap(playlist.getMap),
            ),
          );
        }
      }
      // Converting Entities to Hive
      var songHiveList = PlaylistHiveModel.empty().toHiveList(songEntityList);
      await musicHiveDataSourse.addAllPlaylist(songHiveList);
      return songEntityList;
    }
  }

  Map<String, dynamic> convertMap(Map<dynamic, dynamic> originalMap) {
    Map<String, dynamic> convertedMap = {};
    originalMap.forEach((key, value) {
      if (key is String) {
        convertedMap[key] = value;
      } else {
        convertedMap[key.toString()] = value;
      }
    });
    return convertedMap;
  }

  @override
  Future<void> addAlbums() {
    // TODO: implement addAlbums
    throw UnimplementedError();
  }

  @override
  Future<void> addFolders() {
    // TODO: implement addFolders
    throw UnimplementedError();
  }

  @override
  Future<void> addSongs({
    required List<SongEntity> songs,
    String? token,
  }) {
    // TODO: implement addSongs
    throw UnimplementedError();
  }

  @override
  Future<List<SongEntity>> getAllSongs({String? token}) async {
    // check if music already in hive
    var allHiveSongs = await musicHiveDataSourse.getAllSongs();

    if (allHiveSongs.isNotEmpty) {
      // return song entity if songs in hive
      var allEntitySongs = SongHiveModel.empty().toEntityList(allHiveSongs);
      return allEntitySongs;
    } else {
      final List<SongModel> allQuerySongs = await audioQuery.querySongs(
        sortType: SongSortType.ALBUM,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      // Getting List of SongEntities
      List<SongEntity> songEntityList = [];
      if (allQuerySongs != null) {
        for (var songMap in allQuerySongs) {
          songEntityList.add(
            SongEntity.fromModelMap(
              convertMap(songMap.getMap),
            ),
          );
        }
      }
      // Converting Entities to Hive
      var songHiveList = SongHiveModel.empty().toHiveList(songEntityList);
      await musicHiveDataSourse.addAllSongs(songHiveList);
      return songEntityList;
    }
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MusicQueryRepository {
  final OnAudioQuery audioQuery;
  final HiveQueries localStorage;

  const MusicQueryRepository({
    required this.localStorage,
    required this.audioQuery,
  });

  Future<void> permission() async {
    // await requestAudioQueryPermission();
    var perm = await Permission.storage.status;
    if (perm.isDenied) {
      try {
        await Permission.storage.request();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> requestAudioQueryPermission() async {
    while (!await audioQuery.permissionsStatus()) {
      await audioQuery.permissionsRequest();
    }
  }

  /// Get all songs as a List<dynamic>
  Future<List<dynamic>> getSongsList({String? path}) async {
    const MethodChannel channel =
        MethodChannel('com.lucasjosino.on_audio_query');

    if (path != null) {
      final List<dynamic> allSongs = await channel.invokeMethod(
        "querySongs",
        {
          "path": path,
          "sortType": SongSortType.TITLE.index,
          "orderType": OrderType.ASC_OR_SMALLER.index,
          "uri": UriType.EXTERNAL.index,
          "ignoreCase": true,
        },
      );
      return allSongs;
    } else {
      final List<dynamic> allSongs = await channel.invokeMethod(
        "querySongs",
        {
          "sortType": SongSortType.TITLE.index,
          "orderType": OrderType.ASC_OR_SMALLER.index,
          "uri": UriType.EXTERNAL.index,
          "ignoreCase": true,
        },
      );
      return allSongs;
    }
  }

  /// Get all album as a List<dynamic>
  Future<List<dynamic>> getAlbumsList() async {
    const MethodChannel channel =
        MethodChannel('com.lucasjosino.on_audio_query');

    final List<dynamic> allAlbums = await channel.invokeMethod(
      "queryAlbums",
      {
        "albumSortType": AlbumSortType.ALBUM.index,
        "orderType": OrderType.ASC_OR_SMALLER.index,
        "uri": UriType.EXTERNAL.index,
        "ignoreCase": true,
      },
    );
    return allAlbums;
  }

  Future<List<SongModel>> getAllSongsNoFilter({bool recheck = false}) async {
    try {
      // Check if songs are already cached
      final cachedSongs = await localStorage.getValue(
        boxName: 'songs',
        key: 'allSongs',
        defaultValue: null,
      ) as List<dynamic>?;
      if (cachedSongs != null && !recheck) {
        return cachedSongs.map((e) => SongModel(e)).toList();
      } else {
        // If recheck is true, then we need to update the cache
        //// _audioQuery.querySongs(
        ////   sortType: SongSortType.TITLE,
        ////   orderType: OrderType.ASC_OR_SMALLER,
        ////  uriType: UriType.EXTERNAL,
        ////   ignoreCase: true,
        //// );

        final allSongs = await getSongsList();
        // Cache the songs as a list of Map<String, dynamic>
        localStorage.setValue(
          boxName: 'songs',
          key: 'allSongs',
          value: allSongs,
        );
        // Return the songs as a list of SongModel
        return allSongs.map((e) => SongModel(e)).toList();
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<SongModel>> getAllSongsFilter({bool recheck = false}) {
    throw UnimplementedError();
  }

  Future<List<AlbumModel>> getAlbums({bool recheck = false}) async {
    // Check if songs are already cached
    final cachedAlbums = await localStorage.getValue(
      boxName: 'songs',
      key: 'allAlbums',
      defaultValue: null,
    ) as List<dynamic>?;

    if (cachedAlbums != null && !recheck) {
      return cachedAlbums.map((e) => AlbumModel(e)).toList();
    } else {
      // If recheck is true, then we need to update the cache
      const MethodChannel channel =
          MethodChannel('com.lucasjosino.on_audio_query');

      final List<dynamic> allAlbums = await channel.invokeMethod(
        "queryAlbums",
        {
          "albumSortType": AlbumSortType.ALBUM.index,
          "orderType": OrderType.ASC_OR_SMALLER.index,
          "uri": UriType.EXTERNAL.index,
          "ignoreCase": true,
        },
      );
      // Cache the songs as a list of Map<String, dynamic>
      localStorage.setValue(
        boxName: 'songs',
        key: 'allAlbums',
        value: allAlbums,
      );
      // Return the songs as a list of SongModel
      return allAlbums.map((e) => AlbumModel(e)).toList();
    }
  }

  Future<List<SongModel>> getArtistSongs({bool recheck = false}) {
    // TODO: implement getArtistSongs
    throw UnimplementedError();
  }

  Future<List<SongModel>> getFolderSong({
    bool recheck = false,
    required String path,
  }) async {
    return await audioQuery.querySongs(
      path: path,
      uriType: UriType.EXTERNAL,
      sortType: SongSortType.TITLE,
      orderType: OrderType.ASC_OR_SMALLER,
    );
  }

  Future<List<String>> getFolders({
    bool recheck = false,
  }) async {
    return await audioQuery.queryAllPath();
  }

  Future<String> saveAlbumArt({
    required int id,
    required ArtworkType type,
    required String fileName,
    int size = 200,
    int quality = 100,
    ArtworkFormat format = ArtworkFormat.PNG,
  }) async {
    final String tempPath =
        await path_provider.getTemporaryDirectory().then((value) => value.path);
    final File file = File('$tempPath/$fileName.png');

    if (!await file.exists()) {
      await file.create();
      final Uint8List? image = await audioQuery.queryArtwork(
        id,
        type,
        format: format,
        size: size,
        quality: quality,
      );
      if (image != null) {
        file.writeAsBytesSync(image);
      }
    }
    return file.path;
  }

  Future<Uint8List?> artwork(int id) async {
    return await audioQuery.queryArtwork(
      id,
      ArtworkType.AUDIO,
      size: 200,
      format: ArtworkFormat.PNG,
    );
  }

  ///* Returns a map with the folder path as key and the number of songs as value
  Future<Map<String, List<dynamic>>> folderWithNumberofSongs({
    bool recheck = false,
  }) async {
    // Check if folders are already cached
    final cachedFolders = await localStorage.getValue(
      boxName: 'songs',
      key: 'foldersWithSongs',
      defaultValue: null,
    );
    // If folders are cached and recheck is false, then return the cached folders
    if (cachedFolders != null &&
        !recheck &&
        cachedFolders is Map<String, List<dynamic>>) {
      return cachedFolders;
    } else {
      final folderSongsMap =
          <String, List<dynamic>>{}; // Map of folder path and songs
      final allFolders = await getFolders();
      // from each folder get the songs and put them in a map with the folder path as key
      for (final folder in allFolders) {
        final folderSongs = await getSongsList(path: folder);
        folderSongsMap[folder] = folderSongs;
      }
      // Cache the folders as a Map<String, List<dynamic>>
      localStorage.setValue(
        boxName: 'songs',
        key: 'foldersWithSongs',
        value: folderSongsMap.cast<String, List<dynamic>>(),
      );
      return folderSongsMap;
    }
  }

  Future<Map<String, List<dynamic>>> albumsWithNumberofSongs(
      {bool recheck = false}) async {
    // Check if Albums are already cached
    final cachedAlbums = await localStorage.getValue(
      boxName: 'songs',
      key: 'albumsWithSongs',
      defaultValue: null,
    );
    // final cachedAlbums = null;
    // If Albums are cached and recheck is false, then return the cached Albums
    if (cachedAlbums != null &&
        !recheck &&
        cachedAlbums is Map<String, List<dynamic>>) {
      return cachedAlbums;
    } else {
      final albumSongsMap =
          <String, List<dynamic>>{}; // Map of Albums and songs
      final allSongs = await getSongsList();
      final allAlbums = await getAlbumsList();
      // if the song in the allSongs list has an album name same as the album name in Albums, then add it to the map
      for (final album in allAlbums) {
        // print(album["album"]);
        final albumSongs = allSongs
            .where(
              (element) =>
                  (element['album_id']).toString() == album['album_id'],
            )
            .toList();
        albumSongsMap[album["album"]] = albumSongs;
      }

      //Cache the folders as a Map<String, List<dynamic>>
      localStorage.setValue(
        boxName: 'songs',
        key: 'albumsWithSongs',
        value: albumSongsMap.cast<String, List<dynamic>>(),
      );
      return albumSongsMap;
    }
  }

  Future<Map<String, List<dynamic>>> artistWithNumberofSongs(
      {bool recheck = false}) async {
    // Check if Artists are already cached
    final cachedArtists = await localStorage.getValue(
      boxName: 'songs',
      key: 'artistsWithSongs',
      defaultValue: null,
    );
    // If Artists are cached and recheck is false, then return the cached Artists
    if (cachedArtists != null &&
        !recheck &&
        cachedArtists is Map<String, List<dynamic>>) {
      return cachedArtists;
    } else {
      final artistSongsMap =
          <String, List<dynamic>>{}; // Map of Artists and songs
      final allSongs = await getSongsList();
      // From all songs get the artist name and the artists songs and put them in a map with the artist name as key and the songs as value
      for (final song in allSongs) {
        final artistSongs = allSongs
            .where((element) =>
                (element['artist_id']).toString() ==
                (song['artist_id']).toString())
            .toList();
        artistSongsMap[song["artist"]] = artistSongs;
      }

      //Cache the folders as a Map<String, List<dynamic>>
      localStorage.setValue(
        boxName: 'songs',
        key: 'artistsWithSongs',
        value: artistSongsMap.cast<String, List<dynamic>>(),
      );
      return artistSongsMap;
    }
  }

  Future<Map<String, dynamic>> getEverything() async {
    final folders = await folderWithNumberofSongs();
    final albums = await albumsWithNumberofSongs();
    final artists = await artistWithNumberofSongs();
    return {
      'folders': folders,
      'albums': albums,
      'artists': artists,
    };
  }
}

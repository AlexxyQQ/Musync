import 'package:hive/hive.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/home/data/model/album_hive_model.dart';
import 'package:musync/features/home/data/model/playlist_hive_model.dart';
import 'package:musync/features/home/data/model/song_hive_model.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class MusicHiveDataSourse {
  Future<void> init() async {
    Hive.registerAdapter(SongHiveModelAdapter());
    Hive.registerAdapter(AlbumHiveModelAdapter());
    Hive.registerAdapter(PlaylistHiveModelAdapter());
  }

  // ------------------ All Songs Queries ------------------ //
  Future<void> addAllSongs(List<SongHiveModel> songs) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    for (var song in songs) {
      if (box.containsKey(song.id)) {
        var existingSong = box.get(song.id);
        var updatedSong = existingSong!
            .copyWith(serverUrl: song.serverUrl, albumArtUrl: song.albumArtUrl);
        await box.put(song.id, updatedSong);
      } else {
        await box.put(song.id, song);
      }
    }
  }

  Future<void> updateSong(SongHiveModel song) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);

    await box.put(song.id, song);
  }

  Future<List<SongEntity>> getAllSongs() async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    var songs = box.values.toList().map((e) => e.toEntity()).toList();
    return songs;
  }

  // ------------------ All Albums Queries ------------------ //

  Future<void> addAllAlbums(List<AlbumHiveModel> albums) async {
    var box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    for (var album in albums) {
      await box.put(album.id, album);
    }
  }

  Future<List<AlbumEntity>> getAllAlbums() async {
    var box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    var albums = box.values.toList().map((e) => e.toEntity()).toList();
    return albums;
  }

  Future<void> addAllAlbumWithSongs({
    required Map<String, List<SongEntity>> albumWithSongs,
  }) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    for (var album in albumWithSongs.keys) {
      for (var song in albumWithSongs[album]!) {
        await box.put(song.id, SongHiveModel.empty().toHiveModel(song));
      }
    }
  }

  Future<Map<String, List<SongEntity>>> getAllAlbumsWithSongs() async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    Map<String, List<SongEntity>> albumsWithSongs = {};
    for (var song in box.values.toList()) {
      if (albumsWithSongs.containsKey(song.album)) {
        albumsWithSongs[song.album]!.add(song.toEntity());
      } else {
        albumsWithSongs[song.album] = [song.toEntity()];
      }
    }

    return albumsWithSongs;
  }

  // ------------------ All Folder Queries ------------------ //
  Future<void> addAllFolders(List<String> folders) async {
    await HiveQueries().setValue(
      boxName: 'songs',
      key: 'allSongFolders',
      value: folders,
    );
  }

  Future<List<String>> getAllFolders() async {
    var value = await HiveQueries().getValue(
      boxName: 'songs',
      key: 'allSongFolders',
      defaultValue: List<String>.empty(),
    );

    return value;
  }

  Future<List<SongEntity>> getFolderSongs({required String path}) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    List<SongEntity> folderSongs = [];
    for (var song in box.values.toList()) {
      if (song.data
              .split('/')
              .sublist(0, song.data.split('/').length - 1)
              .join('/') ==
          path) {
        folderSongs.add(song.toEntity());
      }
    }

    return folderSongs;
  }

  Future<Map<String, List<SongEntity>>> getAllFoldersWithSongs() async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    Map<String, List<SongEntity>> foldersWithSongs = {};
    for (var song in box.values.toList()) {
      var folder = song.data
          .split('/')
          .sublist(0, song.data.split('/').length - 1)
          .join('/');
      if (foldersWithSongs.containsKey(folder)) {
        foldersWithSongs[folder]!.add(song.toEntity());
      } else {
        foldersWithSongs[folder] = [song.toEntity()];
      }
    }

    return foldersWithSongs;

    // return await HiveQueries().getValue(
    //   boxName: 'songs',
    //   key: 'foldersWithSongs',
    //   defaultValue: null,
    // );
  }

  // add folder with songs
  Future<void> addFolderWithSongs({
    required Map<String, List<SongEntity>> foldersWithSongs,
  }) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);

    for (var folder in foldersWithSongs.keys) {
      for (var song in foldersWithSongs[folder]!) {
        await box.put(song.id, SongHiveModel.empty().toHiveModel(song));
      }
    }
  }

  // ------------------ All Artist Queries ------------------ //
  Future<Map<String, List<SongEntity>>> getAllArtistsWithSongs() async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    Map<String, List<SongEntity>> artistsWithSongs = {};
    for (var song in box.values.toList()) {
      var artist = song.artist;
      if (artistsWithSongs.containsKey(artist)) {
        artistsWithSongs[artist]!.add(song.toEntity());
      } else {
        artistsWithSongs[artist] = [song.toEntity()];
      }
    }

    return artistsWithSongs;
  }

  Future<void> addAllArtistsWithSongs({
    required Map<String, List<SongEntity>> artistsWithSongs,
  }) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);

    for (var artist in artistsWithSongs.keys) {
      for (var song in artistsWithSongs[artist]!) {
        await box.put(song.id, SongHiveModel.empty().toHiveModel(song));
      }
    }
  }

  // ------------------ All Playlist Queries ------------------ //
  Future<void> addAllPlaylist(List<PlaylistHiveModel> playlists) async {
    var box =
        await Hive.openBox<PlaylistHiveModel>(HiveTableConstant.playlistBox);
    for (var playlist in playlists) {
      if (!box.containsKey(playlist.playlist)) {
        await box.put(playlist.id, playlist);
      }
    }
  }

  Future<List<PlaylistHiveModel>> getAllPlaylist() async {
    var box =
        await Hive.openBox<PlaylistHiveModel>(HiveTableConstant.playlistBox);
    var playlist = box.values.toList();
    return playlist;
  }
}

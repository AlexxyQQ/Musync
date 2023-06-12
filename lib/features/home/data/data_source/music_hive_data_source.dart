import 'package:hive/hive.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/home/data/model/album_hive_model.dart';
import 'package:musync/features/home/data/model/song_hive_model.dart';

class MusicHiveDataSourse {
  Future<void> init() async {
    Hive.registerAdapter(SongHiveModelAdapter());
    Hive.registerAdapter(AlbumHiveModelAdapter());
  }

  // ------------------ All Songs Queries ------------------ //
  Future<void> addAllSongs(List<SongHiveModel> songs) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    for (var song in songs) {
      await box.put(song.id, song);
    }
  }

  Future<List<SongHiveModel>> getAllSongs() async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    var songs = box.values.toList();

    return songs;
  }

  // ------------------ All Albums Queries ------------------ //

  Future<void> addAllAlbums(List<AlbumHiveModel> albums) async {
    var box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    for (var album in albums) {
      await box.put(album.id, album);
    }
  }

  Future<List<AlbumHiveModel>> getAllAlbums() async {
    var box = await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    var albums = box.values.toList();
    return albums;
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

  Future<List<SongHiveModel>> getFolderSongs({required String path}) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    var folderSongs = box.values.where((song) => song.uri == path).toList();
    return folderSongs;
  }

  Future<List<String>> getAllFoldersWithSongs() async {
    return await HiveQueries().getValue(
      boxName: 'songs',
      key: 'foldersWithSongs',
      defaultValue: null,
    );
  }
}

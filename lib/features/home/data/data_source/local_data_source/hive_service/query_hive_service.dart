import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/config/constants/hive/hive_tabel_constant.dart';
import 'package:musync/features/home/data/model/hive/album_hive_model.dart';
import 'package:musync/features/home/data/model/hive/artist_hive_model.dart';
import 'package:musync/features/home/data/model/hive/folder_hive_model.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';

class QueryHiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SongHiveModelAdapter());
    Hive.registerAdapter(ArtistHiveModelAdapter());
    Hive.registerAdapter(AlbumHiveModelAdapter());
    Hive.registerAdapter(FolderHiveModelAdapter());
  }

  // ------------------ All Songs Queries ------------------ //
  Future<List<SongHiveModel>> getAllSongs() async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    var songs = box.values.toList();
    return songs;
  }

  Future<void> addSongs(List<SongHiveModel> songs) async {
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

  Future<void> deleteSong(int id) async {
    var songBox = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    // var albumBox = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);

    // var albumWithSongs = await getAllAlbumsWithSongs();
    // for (var album in albumWithSongs.keys) {
    //   for (var song in albumWithSongs[album]!) {
    //     if (song.id == id) {
    //       await albumBox.delete(id);
    //       return true;
    //     }
    //   }
    // }

    // var folderWithSongs = await getAllFoldersWithSongs();
    // for (var folder in folderWithSongs.keys) {
    //   for (var song in folderWithSongs[folder]!) {
    //     if (song.id == id) {
    //       await songBox.delete(id);
    //       return true;
    //     }
    //   }
    // }

    // var artistWithSongs = await getAllArtistsWithSongs();
    // for (var artist in artistWithSongs.keys) {
    //   for (var song in artistWithSongs[artist]!) {
    //     if (song.id == id) {
    //       await songBox.delete(id);
    //       return true;
    //     }
    //   }
    // }

    await songBox.delete(id);
  }

  Future<void> deleteAllSongs() async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    await box.clear();
  }

  // ------------------ All Albums Queries ------------------ //
  Future<List<AlbumHiveModel>> getAllAlbums() async {
    final albums =
        await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    return albums.values.toList();
  }

  Future<void> addAlbum(AlbumHiveModel album) async {
    final albums =
        await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    await albums.add(album);
  }

  Future<void> addAlbums(List<AlbumHiveModel> albums) async {
    final albumsBox =
        await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    await albumsBox.addAll(albums);
  }

  Future<void> updateAlbums(List<AlbumHiveModel> albums) async {
    final albumsBox =
        await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    await albumsBox.putAll({for (var e in albums) e.id: e});
  }

  Future<void> deleteAlbum(int id) async {
    final albumsBox =
        await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    await albumsBox.delete(id);
  }

  Future<void> deleteAllAlbums() async {
    final albumsBox =
        await Hive.openBox<AlbumHiveModel>(HiveTableConstant.albumBox);
    await albumsBox.clear();
  }

  // ------------------ All Artists Queries ------------------ //
  Future<List<ArtistHiveModel>> getAllArtists() async {
    final artists =
        await Hive.openBox<ArtistHiveModel>(HiveTableConstant.artistBox);
    return artists.values.toList();
  }

  Future<void> addArtist(ArtistHiveModel artist) async {
    final artists =
        await Hive.openBox<ArtistHiveModel>(HiveTableConstant.artistBox);
    await artists.add(artist);
  }

  Future<void> addArtists(List<ArtistHiveModel> artists) async {
    final artistsBox =
        await Hive.openBox<ArtistHiveModel>(HiveTableConstant.artistBox);
    await artistsBox.addAll(artists);
  }

  Future<void> updateArtists(List<ArtistHiveModel> artists) async {
    final artistsBox =
        await Hive.openBox<ArtistHiveModel>(HiveTableConstant.artistBox);
    await artistsBox.putAll({for (var e in artists) e.id: e});
  }

  Future<void> deleteArtist(int id) async {
    final artistsBox =
        await Hive.openBox<ArtistHiveModel>(HiveTableConstant.artistBox);
    await artistsBox.delete(id);
  }

  Future<void> deleteAllArtists() async {
    final artistsBox =
        await Hive.openBox<ArtistHiveModel>(HiveTableConstant.artistBox);
    await artistsBox.clear();
  }

  // ------------------ All Folders Queries ------------------ //

  Future<List<FolderHiveModel>> getAllFolders() async {
    final folders =
        await Hive.openBox<FolderHiveModel>(HiveTableConstant.folderBox);
    return folders.values.toList();
  }

  Future<void> addFolder(FolderHiveModel folder) async {
    final folders =
        await Hive.openBox<FolderHiveModel>(HiveTableConstant.folderBox);
    await folders.add(folder);
  }

  Future<void> addFolders(List<FolderHiveModel> folders) async {
    final foldersBox =
        await Hive.openBox<FolderHiveModel>(HiveTableConstant.folderBox);
    await foldersBox.addAll(folders);
  }

  Future<void> updateFolders(List<FolderHiveModel> folders) async {
    final foldersBox =
        await Hive.openBox<FolderHiveModel>(HiveTableConstant.folderBox);
    await foldersBox.putAll({for (var e in folders) e.path: e});
  }

  Future<void> deleteFolder(int id) async {
    final foldersBox =
        await Hive.openBox<FolderHiveModel>(HiveTableConstant.folderBox);
    await foldersBox.delete(id);
  }

  Future<void> deleteAllFolders() async {
    final foldersBox =
        await Hive.openBox<FolderHiveModel>(HiveTableConstant.folderBox);
    await foldersBox.clear();
  }
}

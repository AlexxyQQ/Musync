import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:musync/features/home/data/model/app_song_model.dart';
import 'package:musync/features/home/data/model/hive/album_hive_model.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../core/utils/song_model_map_converter.dart';

class AppAlbumModel extends AlbumEntity {
  AppAlbumModel({
    required String id,
    required String album,
    required String? artist,
    required String? artistId,
    required int numOfSongs,
    required List<AppSongModel>? songs,
  }) : super(
          id: id,
          album: album,
          artist: artist,
          artistId: artistId,
          numOfSongs: numOfSongs,
          songs: songs,
        );

  factory AppAlbumModel.fromMap(Map<String, dynamic> map) {
    return AppAlbumModel(
      id: map['id'] ?? '',
      album: map['album'] ?? '',
      artist: map['artist'],
      artistId: map['artist_id'],
      numOfSongs: map['num_of_songs']?.toInt() ?? 0,
      songs: map['songs'] != null
          ? List<AppSongModel>.from(
              map['songs']?.map(
                (x) => AppSongModel.fromMap(x),
              ),
            )
          : null,
    );
  }

  factory AppAlbumModel.fromModelMap(Map<String, dynamic> map) {
    return AppAlbumModel(
      id: "${map['_id']}",
      album: map['album'] as String,
      artist: map['artist'] != null ? map['artist'] as String : null,
      artistId: map['album_id'] != null ? "${map['album_id']}" : null,
      numOfSongs: map['numsongs'] as int,
      songs: map['songs'] != null
          ? List<AppSongModel>.from(
              map['songs']?.map(
                (x) => AppSongModel.fromModelMap(x),
              ),
            )
          : null,
    );
  }

  factory AppAlbumModel.fromJson(String source) =>
      AppAlbumModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppAlbumModel Details:\n'
        '  - ID: $id\n'
        '  - Album: $album\n'
        '  - Artist: $artist\n'
        '  - Artist ID: $artistId\n'
        '  - Number of Songs: $numOfSongs\n'
        '  - Songs: ${songs?.join(", ") ?? "None"}'; // Assuming songs is a list, joining them with a comma for better readability
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppAlbumModel &&
        other.id == id &&
        other.album == album &&
        other.artist == artist &&
        other.artistId == artistId &&
        other.numOfSongs == numOfSongs &&
        listEquals(other.songs, songs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        album.hashCode ^
        artist.hashCode ^
        artistId.hashCode ^
        numOfSongs.hashCode ^
        songs.hashCode;
  }

  static AppAlbumModel fromAlbumModel(AlbumModel album) {
    return AppAlbumModel.fromModelMap(convertMap(album.getMap));
  }

  static List<AppAlbumModel> fromListAlbumModle(List<AlbumModel> albums) {
    return albums.map((e) => fromAlbumModel(e)).toList();
  }

  static AppAlbumModel fromHiveModelm(AlbumHiveModel album) {
    return AppAlbumModel.fromMap(album.toMap());
  }

  static List<AppAlbumModel> fromListHiveModel(List<AlbumHiveModel> hiveSongs) {
    return hiveSongs.map((e) => fromHiveModelm(e)).toList();
  }

  static List<AppAlbumModel> fromMapList(List<dynamic> data) {
    return data.map((e) => AppAlbumModel.fromMap(e)).toList();
  }
}

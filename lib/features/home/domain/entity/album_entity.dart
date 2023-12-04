import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:musync/core/utils/song_model_map_converter.dart';
import 'package:musync/features/home/data/model/hive/album_hive_model.dart';

import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumEntity {
  final String id;

  final String album;

  final String? artist;

  final String? artistId;

  final int numOfSongs;

  final List<SongEntity>? songs;

  AlbumEntity({
    required this.id,
    required this.album,
    required this.artist,
    required this.artistId,
    required this.numOfSongs,
    this.songs,
  });

  AlbumEntity copyWith({
    String? id,
    String? album,
    String? artist,
    String? artistId,
    int? numOfSongs,
    List<SongEntity>? songs,
  }) {
    return AlbumEntity(
      id: id ?? this.id,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      artistId: artistId ?? this.artistId,
      numOfSongs: numOfSongs ?? this.numOfSongs,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'album': album});
    if (artist != null) {
      result.addAll({'artist': artist});
    }
    if (artistId != null) {
      result.addAll({'artist_id': artistId});
    }
    result.addAll({'num_of_songs': numOfSongs});
    if (songs != null) {
      result.addAll({'songs': songs!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory AlbumEntity.fromMap(Map<String, dynamic> map) {
    return AlbumEntity(
      id: map['id'] ?? '',
      album: map['album'] ?? '',
      artist: map['artist'],
      artistId: map['artist_id'],
      numOfSongs: map['num_of_songs']?.toInt() ?? 0,
      songs: map['songs'] != null
          ? List<SongEntity>.from(
              map['songs']?.map(
                (x) => SongEntity.fromMap(x),
              ),
            )
          : null,
    );
  }

  factory AlbumEntity.fromModelMap(Map<String, dynamic> map) {
    return AlbumEntity(
      id: "${map['_id']}",
      album: map['album'] as String,
      artist: map['artist'] != null ? map['artist'] as String : null,
      artistId: map['album_id'] != null ? "${map['album_id']}" : null,
      numOfSongs: map['numsongs'] as int,
      songs: map['songs'] != null
          ? List<SongEntity>.from(
              map['songs']?.map(
                (x) => SongEntity.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumEntity.fromJson(String source) =>
      AlbumEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AlbumEntity Details:\n'
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

    return other is AlbumEntity &&
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

  static AlbumEntity fromAlbumModel(AlbumModel album) {
    return AlbumEntity.fromModelMap(convertMap(album.getMap));
  }

  static List<AlbumEntity> fromListAlbumModle(List<AlbumModel> albums) {
    return albums.map((e) => fromAlbumModel(e)).toList();
  }

  // from hive model
  AlbumEntity fromHiveModel(AlbumHiveModel model) {
    return AlbumEntity.fromMap(model.toMap());
  }

  // from list hive model
  static List<AlbumEntity> fromListHiveModel(List<AlbumHiveModel> models) {
    return models.map((e) => AlbumEntity.fromMap(e.toMap())).toList();
  }
}

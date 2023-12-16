import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:musync/features/home/data/model/hive/artist_hive_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../core/utils/song_model_map_converter.dart';
import '../../domain/entity/artist_entity.dart';
import '../../domain/entity/song_entity.dart';

class AppArtistModel extends ArtistEntity {
  AppArtistModel({
    required int id,
    required String artist,
    required int? numberOfAlbums,
    required int? numberOfTracks,
    required List<SongEntity>? songs,
  }) : super(
          id: id,
          artist: artist,
          numberOfAlbums: numberOfAlbums,
          numberOfTracks: numberOfTracks,
          songs: songs,
        );

  factory AppArtistModel.fromMap(Map<String, dynamic> map) {
    return AppArtistModel(
      id: map['id']?.toInt() ?? 0,
      artist: map['artist'] ?? '',
      numberOfAlbums: map['number_of_albums']?.toInt(),
      numberOfTracks: map['number_of_tracks']?.toInt(),
      songs: map['songs'] != null
          ? List<SongEntity>.from(
              map['songs']?.map(
                (x) => SongEntity.fromMap(
                  x,
                ),
              ),
            )
          : null,
    );
  }

  factory AppArtistModel.fromModelMap(Map<String, dynamic> map) {
    return AppArtistModel(
      id: map['_id']?.toInt() ?? 0,
      artist: map['artist'] ?? '',
      numberOfAlbums: map['number_of_albums']?.toInt(),
      numberOfTracks: map['number_of_tracks']?.toInt(),
      songs: map['songs'] != null
          ? List<SongEntity>.from(
              map['songs']?.map(
                (x) => SongEntity.fromMap(
                  x,
                ),
              ),
            )
          : null,
    );
  }

  factory AppArtistModel.fromJson(String source) =>
      AppArtistModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppArtistModel Details:\n'
        '  - ID: $id\n'
        '  - Artist: $artist\n'
        '  - Number of Albums: $numberOfAlbums\n'
        '  - Number of Tracks: $numberOfTracks\n'
        '  - Songs: ${songs?.join(", ") ?? "None"}'; // Assuming songs is a list, joining them for better readability
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppArtistModel &&
        other.id == id &&
        other.artist == artist &&
        other.numberOfAlbums == numberOfAlbums &&
        other.numberOfTracks == numberOfTracks &&
        listEquals(other.songs, songs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        artist.hashCode ^
        numberOfAlbums.hashCode ^
        numberOfTracks.hashCode ^
        songs.hashCode;
  }

  static AppArtistModel fromArtistModel(ArtistModel artist) {
    return AppArtistModel.fromModelMap(convertMap(artist.getMap));
  }

  static List<AppArtistModel> fromListAlbumModle(List<ArtistModel> artists) {
    return artists.map((e) => fromArtistModel(e)).toList();
  }

  static AppArtistModel fromHiveModel(ArtistHiveModel model) {
    return AppArtistModel.fromMap(model.toMap());
  }

  static List<AppArtistModel> fromListHiveModel(
    List<ArtistHiveModel> hiveAlbums,
  ) {
    return hiveAlbums.map((e) => fromHiveModel(e)).toList();
  }
}

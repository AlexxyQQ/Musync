import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../core/utils/song_model_map_converter.dart';

class ArtistEntity {
  final int id;
  final String artist;
  final int? numberOfAlbums;
  final int? numberOfTracks;
  final List<SongEntity>? songs;
  ArtistEntity({
    required this.id,
    required this.artist,
    this.numberOfAlbums,
    this.numberOfTracks,
    this.songs,
  });

  ArtistEntity copyWith({
    int? id,
    String? artist,
    int? numberOfAlbums,
    int? numberOfTracks,
    List<SongEntity>? songs,
  }) {
    return ArtistEntity(
      id: id ?? this.id,
      artist: artist ?? this.artist,
      numberOfAlbums: numberOfAlbums ?? this.numberOfAlbums,
      numberOfTracks: numberOfTracks ?? this.numberOfTracks,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'artist': artist});
    if (numberOfAlbums != null) {
      result.addAll({'number_of_albums': numberOfAlbums});
    }
    if (numberOfTracks != null) {
      result.addAll({'number_of_tracks': numberOfTracks});
    }
    if (songs != null) {
      result.addAll({'songs': songs!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory ArtistEntity.fromMap(Map<String, dynamic> map) {
    return ArtistEntity(
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

  factory ArtistEntity.fromModelMap(Map<String, dynamic> map) {
    return ArtistEntity(
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

  String toJson() => json.encode(toMap());

  factory ArtistEntity.fromJson(String source) =>
      ArtistEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArtistEntity Details:\n'
        '  - ID: $id\n'
        '  - Artist: $artist\n'
        '  - Number of Albums: $numberOfAlbums\n'
        '  - Number of Tracks: $numberOfTracks\n'
        '  - Songs: ${songs?.join(", ") ?? "None"}'; // Assuming songs is a list, joining them for better readability
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArtistEntity &&
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

  static ArtistEntity fromArtistModel(ArtistModel artist) {
    return ArtistEntity.fromModelMap(convertMap(artist.getMap));
  }

  static List<ArtistEntity> fromListAlbumModle(List<ArtistModel> artists) {
    return artists.map((e) => fromArtistModel(e)).toList();
  }
}

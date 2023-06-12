// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlbumEntity {
  final String id;

  final String album;

  final String? artist;

  final String? artistId;

  final int numOfSongs;

  AlbumEntity({
    required this.id,
    required this.album,
    required this.artist,
    required this.artistId,
    required this.numOfSongs,
  });

  AlbumEntity copyWith({
    String? id,
    String? album,
    String? artist,
    String? artistId,
    int? numOfSongs,
  }) {
    return AlbumEntity(
      id: id ?? this.id,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      artistId: artistId ?? this.artistId,
      numOfSongs: numOfSongs ?? this.numOfSongs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'album': album,
      'artist': artist,
      'artistId': artistId,
      'numOfSongs': numOfSongs,
    };
  }

  factory AlbumEntity.fromMap(Map<String, dynamic> map) {
    return AlbumEntity(
      id: "${map['_id']}",
      album: map['album'] as String,
      artist: map['artist'] != null ? map['artist'] as String : null,
      artistId: map['artist_id'] != null ? "${map['artist_id']}" : null,
      numOfSongs: map['numsongs'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumEntity.fromJson(String source) =>
      AlbumEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlbumEntity(id: $id, album: $album, artist: $artist, artistId: $artistId, numOfSongs: $numOfSongs)';
  }

  @override
  bool operator ==(covariant AlbumEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.album == album &&
        other.artist == artist &&
        other.artistId == artistId &&
        other.numOfSongs == numOfSongs;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        album.hashCode ^
        artist.hashCode ^
        artistId.hashCode ^
        numOfSongs.hashCode;
  }
}

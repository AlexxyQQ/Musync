import 'dart:convert';

class PlaylistEntity {
  final String id;
  final String playlist;
  final String? data;
  final int? dateAdded;
  final int? dateModified;
  final int numOfSongs;
  PlaylistEntity({
    required this.id,
    required this.playlist,
    this.data,
    this.dateAdded,
    this.dateModified,
    required this.numOfSongs,
  });

  PlaylistEntity copyWith({
    String? id,
    String? playlist,
    String? data,
    int? dateAdded,
    int? dateModified,
    int? numOfSongs,
  }) {
    return PlaylistEntity(
      id: id ?? this.id,
      playlist: playlist ?? this.playlist,
      data: data ?? this.data,
      dateAdded: dateAdded ?? this.dateAdded,
      dateModified: dateModified ?? this.dateModified,
      numOfSongs: numOfSongs ?? this.numOfSongs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'playlist': playlist,
      'data': data,
      'dateAdded': dateAdded,
      'dateModified': dateModified,
      'numOfSongs': numOfSongs,
    };
  }

  factory PlaylistEntity.fromMap(Map<String, dynamic> map) {
    return PlaylistEntity(
      id: "${map['_id']}",
      playlist: map['name'] as String,
      data: map['_data'] != null ? map['_data'] as String : null,
      dateAdded: map['date_added'] != null ? map['date_added'] as int : null,
      dateModified:
          map['date_modified'] != null ? map['date_modified'] as int : null,
      numOfSongs: map['num_of_songs'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistEntity.fromJson(String source) =>
      PlaylistEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlaylistEntity(id: $id, playlist: $playlist, data: $data, dateAdded: $dateAdded, dateModified: $dateModified, numOfSongs: $numOfSongs)';
  }

  @override
  bool operator ==(covariant PlaylistEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.playlist == playlist &&
        other.data == data &&
        other.dateAdded == dateAdded &&
        other.dateModified == dateModified &&
        other.numOfSongs == numOfSongs;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        playlist.hashCode ^
        data.hashCode ^
        dateAdded.hashCode ^
        dateModified.hashCode ^
        numOfSongs.hashCode;
  }
}

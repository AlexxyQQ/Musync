// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LyricsEntity {
  final String lyrics;
  final int songID;
  LyricsEntity({
    required this.lyrics,
    required this.songID,
  });

  LyricsEntity copyWith({
    String? lyrics,
    int? songID,
  }) {
    return LyricsEntity(
      lyrics: lyrics ?? this.lyrics,
      songID: songID ?? this.songID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lyrics': lyrics,
      'song_id': songID,
    };
  }

  factory LyricsEntity.fromMap(Map<String, dynamic> map) {
    return LyricsEntity(
      lyrics: map['lyrics'] as String,
      songID: map['song_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LyricsEntity.fromJson(String source) =>
      LyricsEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LyricsEntity(lyrics: $lyrics, songID: $songID)';

  @override
  bool operator ==(covariant LyricsEntity other) {
    if (identical(this, other)) return true;

    return other.lyrics == lyrics && other.songID == songID;
  }

  @override
  int get hashCode => lyrics.hashCode ^ songID.hashCode;
}

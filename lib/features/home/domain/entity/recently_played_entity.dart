import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:musync/features/home/domain/entity/song_entity.dart';

class RecentlyPlayedEntity {
  final String date;
  final String expiringDate;
  final List<SongEntity> songs;
  RecentlyPlayedEntity({
    required this.date,
    required this.expiringDate,
    required this.songs,
  });

  factory RecentlyPlayedEntity.empty() {
    return RecentlyPlayedEntity(
      date: '',
      expiringDate: '',
      songs: [],
    );
  }

  RecentlyPlayedEntity copyWith({
    String? date,
    String? expiringDate,
    List<SongEntity>? songs,
  }) {
    return RecentlyPlayedEntity(
      date: date ?? this.date,
      expiringDate: expiringDate ?? this.expiringDate,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'expiring_date': expiringDate,
      'songs': songs.map((x) => x.toMap()).toList(),
    };
  }

  factory RecentlyPlayedEntity.fromMap(Map<String, dynamic> map) {
    return RecentlyPlayedEntity(
      date: map['date'] as String,
      expiringDate: map['expiring_date'] as String,
      songs: List<SongEntity>.from(
        map['songs'].map<SongEntity>(
          (x) => SongEntity.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentlyPlayedEntity.fromJson(String source) =>
      RecentlyPlayedEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RecentlyPlayedEntity(date: $date, expiringDate: $expiringDate, songs: $songs)';

  @override
  bool operator ==(covariant RecentlyPlayedEntity other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.expiringDate == expiringDate &&
        listEquals(other.songs, songs);
  }

  @override
  int get hashCode => date.hashCode ^ expiringDate.hashCode ^ songs.hashCode;
}

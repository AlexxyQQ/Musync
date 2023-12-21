import 'package:flutter/foundation.dart';
import 'package:musync/features/home/data/model/app_song_model.dart';
import 'package:musync/features/home/domain/entity/recently_played_entity.dart';

class AppRecentlyPlayedModel extends RecentlyPlayedEntity {
  AppRecentlyPlayedModel({
    required String date,
    required String expiringDate,
    required List<AppSongModel> songs,
  }) : super(
          date: date,
          expiringDate: expiringDate,
          songs: songs,
        );

  factory AppRecentlyPlayedModel.fromMap(Map<String, dynamic> map) {
    return AppRecentlyPlayedModel(
      date: map['date'] as String,
      expiringDate: map['expiring_date'] as String,
      songs: List<AppSongModel>.from(
        (map['songs'] as List<int>).map<AppSongModel>(
          (x) => AppSongModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() =>
      'AppRecentlyPlayedModel(date: $date, expiringDate: $expiringDate, songs: $songs)';

  @override
  bool operator ==(covariant AppRecentlyPlayedModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.expiringDate == expiringDate &&
        listEquals(other.songs, songs);
  }

  @override
  int get hashCode => date.hashCode ^ expiringDate.hashCode ^ songs.hashCode;
}

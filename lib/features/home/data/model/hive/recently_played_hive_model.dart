import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:musync/features/home/data/model/app_recently_played_model.dart';

import 'package:musync/config/constants/hive/hive_tabel_constant.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';

part 'recently_played_hive_model.g.dart';

@HiveType(
  typeId: HiveTableConstant.recentlyPlayedTableId,
)
class RecentlyPlayedHiveModel {
  @HiveField(0)
  final String date;

  @HiveField(1)
  final String expiringDate;

  @HiveField(2)
  final List<SongHiveModel> songs;
  RecentlyPlayedHiveModel({
    required this.date,
    required this.expiringDate,
    required this.songs,
  });

  static RecentlyPlayedHiveModel fromAppAlbumModel(
    AppRecentlyPlayedModel model,
  ) {
    return RecentlyPlayedHiveModel.fromMap(model.toMap());
  }

  static List<RecentlyPlayedHiveModel> fromAppAlbumModelList(
    List<AppRecentlyPlayedModel> modelList,
  ) {
    return modelList.map((e) => fromAppAlbumModel(e)).toList();
  }

  RecentlyPlayedHiveModel copyWith({
    String? date,
    String? expiringDate,
    List<SongHiveModel>? songs,
  }) {
    return RecentlyPlayedHiveModel(
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

  factory RecentlyPlayedHiveModel.fromMap(Map<String, dynamic> map) {
    return RecentlyPlayedHiveModel(
      date: map['date'] as String,
      expiringDate: map['expiring_date'] as String,
      songs: List<SongHiveModel>.from(
        (map['songs'] as List<int>).map<SongHiveModel>(
          (x) => SongHiveModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentlyPlayedHiveModel.fromJson(String source) =>
      RecentlyPlayedHiveModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'RecentlyPlayedHiveModel(date: $date, expiringDate: $expiringDate, songs: $songs)';

  @override
  bool operator ==(covariant RecentlyPlayedHiveModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.expiringDate == expiringDate &&
        listEquals(other.songs, songs);
  }

  @override
  int get hashCode => date.hashCode ^ expiringDate.hashCode ^ songs.hashCode;
}

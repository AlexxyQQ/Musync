import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/core/utils/song_model_map_converter.dart';
import 'package:musync/features/home/data/model/app_album_model.dart';
import 'package:musync/features/home/data/model/app_song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'album_hive_model.g.dart';

@HiveType(
  typeId: HiveTableConstant.albumTableId,
)
class AlbumHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String album;

  @HiveField(2)
  final String? artist;

  @HiveField(3)
  final String? artistId;

  @HiveField(4)
  final int numOfSongs;

  @HiveField(5)
  final List<AppSongModel>? songs;

  AlbumHiveModel({
    required this.id,
    required this.album,
    this.artist,
    this.artistId,
    required this.numOfSongs,
    this.songs,
  });

  factory AlbumHiveModel.fromMap(Map<String, dynamic> map) {
    return AlbumHiveModel(
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

  factory AlbumHiveModel.fromJson(String source) =>
      AlbumHiveModel.fromMap(json.decode(source));

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

  @override
  String toString() {
    return 'AlbumHiveModel Details:\n'
        '  - ID: $id\n'
        '  - Album: $album\n'
        '  - Artist: $artist\n'
        '  - Artist ID: $artistId\n'
        '  - Number of Songs: $numOfSongs\n'
        '  - Songs: ${songs?.join(", ") ?? "None"}'; // Assuming songs is a list, joining them with a comma for better readability
  }

  static AppAlbumModel fromHiveModel(AlbumHiveModel hiveObject) {
    return AppAlbumModel(
      id: hiveObject.id,
      album: hiveObject.album,
      artist: hiveObject.artist,
      artistId: hiveObject.artistId,
      numOfSongs: hiveObject.numOfSongs,
      songs: hiveObject.songs,
    );
  }

  static List<AppAlbumModel> fromHiveList(List<AlbumHiveModel> hiveList) {
    return hiveList.map((e) => fromHiveModel(e)).toList();
  }

  factory AlbumHiveModel.fromModelMap(Map<String, dynamic> map) {
    return AlbumHiveModel(
      id: map['id'] ?? '',
      album: map['album'] ?? '',
      artist: map['artist'] ?? '',
      artistId: map['artist_id'] ?? '',
      numOfSongs: map['numsongs']?.toInt() ?? 0,
      songs: map['songs'] != null
          ? List<AppSongModel>.from(
              map['songs']?.map(
                (x) => AppSongModel.fromMap(x),
              ),
            )
          : null,
    );
  }

  static AlbumHiveModel fromModel(AlbumModel model) {
    return AlbumHiveModel.fromModelMap(convertMap(model.getMap));
  }

  static List<AlbumHiveModel> fromModelList(List<AlbumModel> modelList) {
    return modelList.map((e) => fromModel(e)).toList();
  }

  static AlbumHiveModel fromAppAlbumModel(AppAlbumModel model) {
    return AlbumHiveModel.fromMap(model.toMap());
  }

  static List<AlbumHiveModel> fromAppAlbumModelList(
    List<AppAlbumModel> modelList,
  ) {
    return modelList.map((e) => fromAppAlbumModel(e)).toList();
  }

  AlbumHiveModel copyWith({
    String? id,
    String? album,
    String? artist,
    String? artistId,
    int? numOfSongs,
    List<AppSongModel>? songs,
  }) {
    return AlbumHiveModel(
      id: id ?? this.id,
      album: album ?? this.album,
      artist: artist ?? this.artist,
      artistId: artistId ?? this.artistId,
      numOfSongs: numOfSongs ?? this.numOfSongs,
      songs: songs ?? this.songs,
    );
  }

  String toJson() => json.encode(toMap());
}

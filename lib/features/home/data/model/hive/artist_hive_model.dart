import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/features/home/data/model/app_artist_model.dart';
import 'package:musync/features/home/data/model/app_song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../../core/utils/song_model_map_converter.dart';

part 'artist_hive_model.g.dart';

@HiveType(
  typeId: HiveTableConstant.artistTableId,
)
class ArtistHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String artist;

  @HiveField(2)
  final int? numberOfAlbums;

  @HiveField(3)
  final int? numberOfTracks;

  @HiveField(4)
  final List<AppSongModel>? songs;
  ArtistHiveModel({
    required this.id,
    required this.artist,
    this.numberOfAlbums,
    this.numberOfTracks,
    this.songs,
  });

  ArtistHiveModel copyWith({
    String? id,
    String? artist,
    int? numberOfAlbums,
    int? numberOfTracks,
    List<AppSongModel>? songs,
  }) {
    return ArtistHiveModel(
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

  factory ArtistHiveModel.fromMap(Map<String, dynamic> map) {
    return ArtistHiveModel(
      id: map['id'] ?? '',
      artist: map['artist'] ?? '',
      numberOfAlbums: map['number_of_albums']?.toInt(),
      numberOfTracks: map['numberOfTracks']?.toInt(),
      songs: map['songs'] != null
          ? List<AppSongModel>.from(
              map['songs']?.map(
                (x) => AppSongModel.fromMap(
                  x,
                ),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArtistHiveModel.fromJson(String source) =>
      ArtistHiveModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArtistHiveModel Details:\n'
        '  - ID: $id\n'
        '  - Artist: $artist\n'
        '  - Number of Albums: $numberOfAlbums\n'
        '  - Number of Tracks: $numberOfTracks\n'
        '  - Songs: ${songs?.join(", ") ?? "None"}'; // Assuming songs is a list, joining them for better readability
  }

  factory ArtistHiveModel.fromModelMap(Map<String, dynamic> map) {
    return ArtistHiveModel(
      id: map['_id'] ?? '',
      artist: map['artist'] ?? '',
      numberOfAlbums: map['number_of_albums']?.toInt(),
      numberOfTracks: map['number_of_tracks']?.toInt(),
      songs: map['songs'] != null
          ? List<AppSongModel>.from(
              map['songs']?.map(
                (x) => AppSongModel.fromMap(
                  x,
                ),
              ),
            )
          : null,
    );
  }

  static ArtistHiveModel fromModel(ArtistModel model) {
    return ArtistHiveModel.fromModelMap(convertMap(model.getMap));
  }

  static List<ArtistHiveModel> fromModelList(List<ArtistModel> modelList) {
    return modelList.map((e) => fromModel(e)).toList();
  }

  static ArtistHiveModel fromAppArtistModel(AppArtistModel model) {
    return ArtistHiveModel.fromMap(model.toMap());
  }

  static List<ArtistHiveModel> fromAppArtistModelList(
    List<AppArtistModel> modelList,
  ) {
    return modelList.map((e) => fromAppArtistModel(e)).toList();
  }
}

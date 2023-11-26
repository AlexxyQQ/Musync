import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'playlist_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.playlistTableId)
class PlaylistHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String playlist;

  @HiveField(2)
  final String data;

  @HiveField(3)
  final int dateAdded;

  @HiveField(4)
  final int numOfSongs;

  @HiveField(5)
  final int dateModified;

  PlaylistHiveModel.empty()
      : this(
          id: '',
          playlist: '',
          data: '',
          dateAdded: 0,
          numOfSongs: 0,
          dateModified: 0,
        );

  PlaylistHiveModel({
    required this.id,
    required this.playlist,
    int? dateModified,
    int? dateAdded,
    String? data,
    required this.numOfSongs,
  })  : data = data ?? '',
        dateModified = dateModified ?? 0,
        dateAdded = dateAdded ?? 0;

  PlaylistEntity toEntity() => PlaylistEntity(
        id: id,
        data: data,
        dateAdded: dateAdded,
        dateModified: dateModified,
        playlist: playlist,
        numOfSongs: numOfSongs,
      );

  PlaylistModel toPlaylistModel(PlaylistEntity entity) => PlaylistModel({
        "_id": entity.id,
        "name": entity.playlist,
        "_data": entity.data,
        "date_added": entity.dateAdded,
        "date_modified": entity.dateModified,
        "num_of_songs": entity.numOfSongs,
      });

  PlaylistHiveModel toHiveModelFromEntity(PlaylistEntity entity) =>
      PlaylistHiveModel(
        id: entity.id,
        playlist: entity.playlist,
        data: entity.data,
        dateAdded: entity.dateAdded,
        numOfSongs: entity.numOfSongs,
        dateModified: entity.dateModified,
      );
  PlaylistHiveModel toHiveModelFromPlaylistModel(PlaylistModel model) =>
      PlaylistHiveModel(
        id: "${model.id}",
        playlist: model.playlist,
        data: model.data,
        dateAdded: model.dateAdded,
        numOfSongs: model.numOfSongs,
        dateModified: model.dateModified,
      );

  List<PlaylistEntity> toEntityList(List<PlaylistHiveModel> models) =>
      models.map((e) => e.toEntity()).toList();
  List<PlaylistHiveModel> toHiveList(List<PlaylistEntity> entities) =>
      entities.map((e) => toHiveModelFromEntity(e)).toList();
  List<PlaylistModel> toModelList(List<PlaylistEntity> entities) =>
      entities.map((e) => toPlaylistModel(e)).toList();
}

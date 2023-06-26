import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'album_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.albumTableId)
class AlbumHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String album;

  @HiveField(2)
  final String artist;

  @HiveField(3)
  final String artistId;

  @HiveField(4)
  final int numOfSongs;

  AlbumHiveModel.empty()
      : this(
          id: '',
          album: '',
          artist: '',
          artistId: '',
          numOfSongs: 0,
        );

  AlbumHiveModel({
    required this.id,
    required this.album,
    String? artist,
    String? artistId,
    required this.numOfSongs,
  })  : artist = artist ?? '',
        artistId = artistId ?? '';

  AlbumEntity toEntity() => AlbumEntity(
        id: id,
        album: album,
        artist: artist,
        artistId: artistId,
        numOfSongs: numOfSongs,
      );

  AlbumHiveModel toHiveModel(AlbumEntity entity) => AlbumHiveModel(
        id: entity.id,
        album: entity.album,
        artist: entity.artist,
        artistId: entity.artistId,
        numOfSongs: entity.numOfSongs,
      );

  AlbumModel toAlbumModel(AlbumEntity entity) => AlbumModel({
        "_id": entity.id,
        "album": entity.album,
        "artist": entity.artist,
        "artist_id": entity.artistId,
        "numsongs": entity.numOfSongs,
      });

  List<AlbumEntity> toEntityList(List<AlbumHiveModel> models) =>
      models.map((e) => e.toEntity()).toList();
  List<AlbumHiveModel> toHiveList(List<AlbumEntity> entities) =>
      entities.map((e) => toHiveModel(e)).toList();
  List<AlbumModel> toModelList(List<AlbumEntity> entities) =>
      entities.map((e) => toAlbumModel(e)).toList();
}

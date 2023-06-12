import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/config/constants/hive_tabel_constant.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

part 'song_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.songTableId)
class SongHiveModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String data;

  @HiveField(2)
  final String uri;

  @HiveField(3)
  final String displayName;

  @HiveField(4)
  final String displayNameWOExt;

  @HiveField(5)
  final int size;

  @HiveField(6)
  final String album;

  @HiveField(7)
  final String albumId;

  @HiveField(8)
  final String artist;

  @HiveField(9)
  final String artistId;

  @HiveField(10)
  final String genre;

  @HiveField(11)
  final String genreId;

  @HiveField(12)
  final int bookmark;

  @HiveField(13)
  final String composer;

  @HiveField(14)
  final int dateAdded;

  @HiveField(15)
  final int dateModified;

  @HiveField(16)
  final int duration;

  @HiveField(17)
  final String title;

  @HiveField(18)
  final int track;

  @HiveField(19)
  final String fileExtension;

  @HiveField(20)
  final bool isAlarm;

  @HiveField(21)
  final bool isAudioBook;

  @HiveField(22)
  final bool isMusic;

  @HiveField(23)
  final bool isNotification;

  @HiveField(24)
  final bool isPodcast;

  @HiveField(25)
  final bool isRingtone;

  SongHiveModel.empty()
      : this(
          id: 0,
          data: '',
          uri: '',
          displayName: '',
          displayNameWOExt: '',
          size: 0,
          album: '',
          albumId: '',
          artist: '',
          artistId: '',
          genre: '',
          genreId: '',
          bookmark: 0,
          composer: '',
          dateAdded: 0,
          dateModified: 0,
          duration: 0,
          title: '',
          track: 0,
          fileExtension: '',
          isAlarm: false,
          isAudioBook: false,
          isMusic: false,
          isNotification: false,
          isPodcast: false,
          isRingtone: false,
        );

  SongHiveModel({
    required this.id,
    required this.data,
    String? uri,
    required this.displayName,
    required this.displayNameWOExt,
    required this.size,
    String? album,
    String? albumId,
    String? artist,
    String? artistId,
    String? genre,
    String? genreId,
    int? bookmark,
    String? composer,
    int? dateAdded,
    int? dateModified,
    int? duration,
    required this.title,
    int? track,
    required this.fileExtension,
    bool? isAlarm,
    bool? isAudioBook,
    bool? isMusic,
    bool? isNotification,
    bool? isPodcast,
    required this.isRingtone,
  })  : uri = uri ?? "",
        album = album ?? '',
        albumId = albumId ?? '',
        artist = artist ?? '',
        artistId = artistId ?? '',
        genre = genre ?? '',
        genreId = genreId ?? '',
        bookmark = bookmark ?? 0,
        composer = composer ?? '',
        dateAdded = dateAdded ?? 0,
        dateModified = dateModified ?? 0,
        duration = duration ?? 0,
        track = track ?? 0,
        isAlarm = isAlarm ?? false,
        isAudioBook = isAudioBook ?? false,
        isMusic = isMusic ?? false,
        isNotification = isNotification ?? false,
        isPodcast = isPodcast ?? false;

  SongEntity toEntity() => SongEntity(
        id: id,
        data: data,
        uri: uri,
        displayName: displayName,
        displayNameWOExt: displayNameWOExt,
        size: size,
        album: album,
        albumId: albumId,
        artist: artist,
        artistId: artistId,
        genre: genre,
        genreId: genreId,
        bookmark: bookmark,
        composer: composer,
        dateAdded: dateAdded,
        dateModified: dateModified,
        duration: duration,
        title: title,
        track: track,
        fileExtension: fileExtension,
        isAlarm: isAlarm,
        isAudioBook: isAudioBook,
        isMusic: isMusic,
        isNotification: isNotification,
        isPodcast: isPodcast,
        isRingtone: isRingtone,
      );
  SongHiveModel toHiveModel(SongEntity entity) => SongHiveModel(
        id: entity.id,
        data: entity.data,
        uri: entity.uri,
        displayName: entity.displayName,
        displayNameWOExt: entity.displayNameWOExt,
        size: entity.size,
        album: entity.album,
        albumId: entity.albumId,
        artist: entity.artist,
        artistId: entity.artistId,
        genre: entity.genre,
        genreId: entity.genreId,
        bookmark: entity.bookmark,
        composer: entity.composer,
        dateAdded: entity.dateAdded,
        dateModified: entity.dateModified,
        duration: entity.duration,
        title: entity.title,
        track: entity.track,
        fileExtension: entity.fileExtension,
        isAlarm: entity.isAlarm,
        isAudioBook: entity.isAudioBook,
        isMusic: entity.isMusic,
        isNotification: entity.isNotification,
        isPodcast: entity.isPodcast,
        isRingtone: entity.isRingtone,
      );

  List<SongEntity> toEntityList(List<SongHiveModel> models) =>
      models.map((e) => e.toEntity()).toList();
  List<SongHiveModel> toHiveList(List<SongEntity> entities) =>
      entities.map((e) => toHiveModel(e)).toList();
}

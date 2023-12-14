import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:musync/config/constants/hive/hive_tabel_constant.dart';
import 'package:musync/features/home/data/model/app_song_model.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

  @HiveField(26)
  final String serverUrl;

  @HiveField(27)
  final String? albumArt;

  @HiveField(28)
  final String? albumArtUrl;

  @HiveField(29)
  final bool isPublic;

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
          serverUrl: '',
          albumArt: '',
          albumArtUrl: '',
          isPublic: false,
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
    String? serverUrl,
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
    required this.albumArt,
    String? albumArtUrl,
    bool? isPublic,
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
        isPodcast = isPodcast ?? false,
        albumArtUrl = albumArtUrl ?? '',
        isPublic = isPublic ?? false,
        serverUrl = serverUrl ?? '';

  SongEntity toEntity() => SongEntity(
        id: id,
        data: data,
        serverUrl: serverUrl,
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
        albumArt: albumArt ?? '',
        albumArtUrl: albumArtUrl ?? '',
        isPublic: isPublic,
      );
  SongHiveModel toHiveModel(SongEntity entity) => SongHiveModel(
        id: entity.id,
        data: entity.data,
        serverUrl: entity.serverUrl,
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
        albumArt: entity.albumArt,
        albumArtUrl: entity.albumArtUrl,
        isPublic: entity.isPublic,
      );

  SongModel toSongModel(SongEntity entity) => SongModel({
        "_id": entity.id,
        "_data": entity.data,
        "_uri": entity.uri,
        "_display_name": entity.displayName,
        "_display_name_wo_ext": entity.displayNameWOExt,
        "_size": entity.size,
        "album": entity.album,
        "album_id": entity.albumId,
        "artist": entity.artist,
        "artist_id": entity.artistId,
        "genre": entity.genre,
        "genre_id": entity.genreId,
        "bookmark": entity.bookmark,
        "composer": entity.composer,
        "date_added": entity.dateAdded,
        "date_modified": entity.dateModified,
        "duration": entity.duration,
        "title": entity.title,
        "track": entity.track,
        "file_extension": entity.fileExtension,
        "is_alarm": entity.isAlarm,
        "is_audiobook": entity.isAudioBook,
        "is_music": entity.isMusic,
        "is_notification": entity.isNotification,
        "is_podcast": entity.isPodcast,
        "is_ringtone": entity.isRingtone,
      });

  List<SongEntity> toEntityList(List<SongHiveModel> models) =>
      models.map((e) => e.toEntity()).toList();
  List<SongEntity> toCheckEntityList(List<SongHiveModel> models) {
    List<SongEntity> songEntityList = [];
    for (var model in models) {
      SongEntity songEntity = model.toEntity();
      if (File(songEntity.data).existsSync()) {
        songEntityList.add(songEntity);
      }
    }
    return songEntityList;
  }

  List<SongHiveModel> toHiveList(List<SongEntity> entities) =>
      entities.map((e) => toHiveModel(e)).toList();

  List<SongModel> toModelList(List<SongEntity> entities) =>
      entities.map((e) => toSongModel(e)).toList();

  SongHiveModel copyWith({
    int? id,
    String? data,
    String? uri,
    String? displayName,
    String? displayNameWOExt,
    int? size,
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
    String? title,
    int? track,
    String? fileExtension,
    bool? isAlarm,
    bool? isAudioBook,
    bool? isMusic,
    bool? isNotification,
    bool? isPodcast,
    bool? isRingtone,
    String? serverUrl,
    String? albumArt,
    String? albumArtUrl,
    bool? isPublic,
  }) {
    return SongHiveModel(
      id: id ?? this.id,
      data: data ?? this.data,
      uri: uri ?? this.uri,
      displayName: displayName ?? this.displayName,
      displayNameWOExt: displayNameWOExt ?? this.displayNameWOExt,
      size: size ?? this.size,
      album: album ?? this.album,
      albumId: albumId ?? this.albumId,
      artist: artist ?? this.artist,
      artistId: artistId ?? this.artistId,
      genre: genre ?? this.genre,
      genreId: genreId ?? this.genreId,
      bookmark: bookmark ?? this.bookmark,
      composer: composer ?? this.composer,
      dateAdded: dateAdded ?? this.dateAdded,
      dateModified: dateModified ?? this.dateModified,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      track: track ?? this.track,
      fileExtension: fileExtension ?? this.fileExtension,
      isAlarm: isAlarm ?? this.isAlarm,
      isAudioBook: isAudioBook ?? this.isAudioBook,
      isMusic: isMusic ?? this.isMusic,
      isNotification: isNotification ?? this.isNotification,
      isPodcast: isPodcast ?? this.isPodcast,
      isRingtone: isRingtone ?? this.isRingtone,
      serverUrl: serverUrl ?? this.serverUrl,
      albumArt: albumArt ?? this.albumArt,
      albumArtUrl: albumArtUrl ?? this.albumArtUrl,
      isPublic: isPublic ?? this.isPublic,
    );
  }

  toAppSongModel() {
    return AppSongModel(
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
      serverUrl: serverUrl,
      albumArt: albumArt ?? '',
      albumArtUrl: albumArtUrl,
      isPublic: isPublic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'data': data,
      'uri': uri,
      'display_name': displayName,
      'display_name_wo_ext': displayNameWOExt,
      'size': size,
      'album': album,
      'album_id': albumId,
      'artist': artist,
      'artist_id': artistId,
      'genre': genre,
      'genre_id': genreId,
      'bookmark': bookmark,
      'composer': composer,
      'date_added': dateAdded,
      'date_modified': dateModified,
      'duration': duration,
      'title': title,
      'track': track,
      'file_extension': fileExtension,
      'is_alarm': isAlarm,
      'is_audiobook': isAudioBook,
      'is_music': isMusic,
      'is_notification': isNotification,
      'is_podcast': isPodcast,
      'is_ringtone': isRingtone,
      'server_url': serverUrl,
      'album_art': albumArt,
      'album_art_url': albumArtUrl,
      'is_public': isPublic,
    };
  }

  @override
  String toString() {
    return 'SongHiveModel Details:\n'
        '  - ID: $id\n'
        '  - Data: $data\n'
        '  - Server URL: $serverUrl\n'
        '  - URI: $uri\n'
        '  - Display Name: $displayName\n'
        '  - Display Name Without Extension: $displayNameWOExt\n'
        '  - Size: $size\n'
        '  - Album: $album\n'
        '  - Album ID: $albumId\n'
        '  - Artist: $artist\n'
        '  - Artist ID: $artistId\n'
        '  - Genre: $genre\n'
        '  - Genre ID: $genreId\n'
        '  - Bookmark: $bookmark\n'
        '  - Composer: $composer\n'
        '  - Date Added: $dateAdded\n'
        '  - Date Modified: $dateModified\n'
        '  - Duration: $duration\n'
        '  - Title: $title\n'
        '  - Track: $track\n'
        '  - File Extension: $fileExtension\n'
        '  - Is Alarm: $isAlarm\n'
        '  - Is Audio Book: $isAudioBook\n'
        '  - Is Music: $isMusic\n'
        '  - Is Notification: $isNotification\n'
        '  - Is Podcast: $isPodcast\n'
        '  - Is Ringtone: $isRingtone';
  }
}

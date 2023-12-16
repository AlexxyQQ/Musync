import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'package:musync/config/constants/api/api_endpoints.dart';
import 'package:musync/core/utils/song_model_map_converter.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongEntity extends Equatable {
  final int id;

  final String data;

  final String? serverUrl;

  final String? uri;

  final String displayName;

  final String displayNameWOExt;

  final int size;

  final String? album;

  final String? albumId;

  final String? artist;

  final String? artistId;

  final String? genre;

  final String? genreId;

  final int? bookmark;

  final String? composer;

  final int? dateAdded;

  final int? dateModified;

  final int? duration;

  final String title;

  final int? track;

  final String fileExtension;

  final bool? isAlarm;

  final bool? isAudioBook;

  final bool? isMusic;

  final bool? isNotification;

  final bool? isPodcast;

  final bool isRingtone;

  final String albumArt;

  final String? albumArtUrl;

  final bool? isPublic;

  const SongEntity({
    required this.id,
    required this.data,
    required this.uri,
    required this.displayName,
    required this.displayNameWOExt,
    required this.size,
    required this.albumArt,
    this.album,
    this.serverUrl,
    this.albumId,
    this.artist,
    this.artistId,
    this.genre,
    this.genreId,
    this.bookmark,
    this.composer,
    this.dateAdded,
    this.dateModified,
    this.duration,
    required this.title,
    this.track,
    required this.fileExtension,
    this.isAlarm,
    this.isAudioBook,
    this.isMusic,
    this.isNotification,
    this.isPodcast,
    required this.isRingtone,
    this.albumArtUrl,
    this.isPublic,
  });

  SongEntity copyWith({
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
    return SongEntity(
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

  factory SongEntity.fromModelMap(Map<String, dynamic> map) {
    return SongEntity(
      id: map['_id'] as int,
      data: map['_data'] as String,
      uri: map['_uri'] != null ? map['_uri'] as String : null,
      displayName: map['_display_name'] as String,
      displayNameWOExt: map['_display_name_wo_ext'] as String,
      size: map['_size'] as int,
      album: map['album'] != null ? map['album'] as String : null,
      albumId: map['album_id'] != null ? "${map['album_id']}" : null,
      artist: map['artist'] != null ? map['artist'] as String : null,
      artistId: map['artist_id'] != null ? "${map['artist_id']}" : null,
      genre: map['genre'] != null ? map['genre'] as String : null,
      genreId: map['genre_id'] != null ? map['genre_id'] as String : null,
      bookmark: map['bookmark'] != null ? map['bookmark'] as int : null,
      composer: map['composer'] != null ? map['composer'] as String : null,
      dateAdded: map['date_added'] != null ? map['date_added'] as int : null,
      dateModified:
          map['date_modified'] != null ? map['date_modified'] as int : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
      title: map['title'] as String,
      track: map['track'] != null ? map['track'] as int : null,
      fileExtension: map['file_extension'] as String,
      isAlarm: map['is_alarm'] != null ? map['is_alarm'] as bool : null,
      isAudioBook:
          map['is_audiobook'] != null ? map['is_audiobook'] as bool : null,
      isMusic: map['is_music'] != null ? map['is_music'] as bool : null,
      isNotification: map['is_notification'] != null
          ? map['is_notification'] as bool
          : null,
      isPodcast: map['is_podcast'] != null ? map['is_podcast'] as bool : null,
      isRingtone: map['is_ringtone'] as bool,
      serverUrl: map['server_url'] != null ? map['server_url'] as String : null,
      albumArt: map['albumArt'] != null ? map['albumArt'] as String : '',
      albumArtUrl:
          map['albumArtUrl'] != null ? map['albumArtUrl'] as String : null,
      isPublic: map['isPublic'] != null ? map['isPublic'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SongEntity.fromJson(String source) =>
      SongEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongEntity Details:\n'
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

  factory SongEntity.fromMap(Map<String, dynamic> map) {
    return SongEntity(
      id: map['id'] as int,
      data: map['data'] as String,
      albumArt: map['album_art'] as String,
      albumArtUrl: map['album_art_url'] != null
          ? "${ApiEndpoints.baseDomain}${map['album_art_url']}"
          : null,
      serverUrl: map['server_url'] as String,
      uri: map['uri'] != null ? map['uri'] as String : null,
      displayName: map['display_name'] as String,
      displayNameWOExt: map['display_name_wo_ext'] as String,
      size: map['size'] as int,
      album: map['album'] != null ? map['album'] as String : null,
      albumId: map['album_id'] != null ? map['album_id'] as String : null,
      artist: map['artist'] != null ? map['artist'] as String : null,
      artistId: map['artist_id'] != null ? map['artist_id'] as String : null,
      genre: map['genre'] != null ? map['genre'] as String : null,
      genreId: map['genre_id'] != null ? map['genre_id'] as String : null,
      bookmark: map['bookmark'] != null ? map['bookmark'] as int : null,
      composer: map['composer'] != null ? map['composer'] as String : null,
      dateAdded: map['date_added'] != null ? map['date_added'] as int : null,
      dateModified:
          map['date_modified'] != null ? map['date_modified'] as int : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
      title: map['title'] as String,
      track: map['track'] != null ? map['track'] as int : null,
      fileExtension: map['file_extension'] as String,
      isAlarm: map['is_alarm'] != null ? map['is_alarm'] as bool : null,
      isAudioBook:
          map['is_audio_book'] != null ? map['is_audio_book'] as bool : null,
      isMusic: map['is_music'] != null ? map['is_music'] as bool : null,
      isNotification: map['is_notification'] != null
          ? map['is_notification'] as bool
          : null,
      isPodcast: map['is_podcast'] != null ? map['is_podcast'] as bool : null,
      isRingtone: map['is_ringtone'] as bool,
      isPublic: map['is_public'] != null ? map['is_public'] as bool : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        data,
        serverUrl,
        uri,
        displayName,
        displayNameWOExt,
        size,
        album,
        albumId,
        artist,
        artistId,
        genre,
        genreId,
        bookmark,
        composer,
        dateAdded,
        dateModified,
        duration,
        title,
        track,
        fileExtension,
        isAlarm,
        isAudioBook,
        isMusic,
        isNotification,
        isPodcast,
        isRingtone,
        albumArt,
        albumArtUrl,
        isPublic,
      ];

  SongHiveModel toHiveModel() {
    return SongHiveModel(
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
      albumArt: albumArt,
      albumArtUrl: albumArtUrl,
      isPublic: isPublic,
    );
  }

  static List<SongHiveModel> toListHiveModel(List<SongEntity> songs) {
    return songs.map((e) => e.toHiveModel()).toList();
  }

  static List<SongEntity> fromListHiveModel(List<SongHiveModel> songs) {
    return songs.map((e) => e.toEntity()).toList();
  }

  static SongEntity formSongModel(SongModel song) {
    return SongEntity.fromModelMap(convertMap(song.getMap));
  }

  static List<SongEntity> fromListSongModel(List<SongModel> songs) {
    return songs.map((e) => formSongModel(e)).toList();
  }
}

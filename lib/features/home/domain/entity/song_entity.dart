import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';

import 'package:musync/config/constants/api_endpoints.dart';

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
      'displayName': displayName,
      'displayNameWOExt': displayNameWOExt,
      'size': size,
      'album': album,
      'albumId': albumId,
      'artist': artist,
      'artistId': artistId,
      'genre': genre,
      'genreId': genreId,
      'bookmark': bookmark,
      'composer': composer,
      'dateAdded': dateAdded,
      'dateModified': dateModified,
      'duration': duration,
      'title': title,
      'track': track,
      'fileExtension': fileExtension,
      'isAlarm': isAlarm,
      'isAudioBook': isAudioBook,
      'isMusic': isMusic,
      'isNotification': isNotification,
      'isPodcast': isPodcast,
      'isRingtone': isRingtone,
      'serverUrl': serverUrl,
      'albumArt': albumArt,
      'albumArtUrl': albumArtUrl,
      'isPublic': isPublic,
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
      SongEntity.fromApiMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongEntity(id: $id, data: $data, serverUrl: $serverUrl, uri: $uri, displayName: $displayName, displayNameWOExt: $displayNameWOExt, size: $size, album: $album, albumId: $albumId, artist: $artist, artistId: $artistId, genre: $genre, genreId: $genreId, bookmark: $bookmark, composer: $composer, dateAdded: $dateAdded, dateModified: $dateModified, duration: $duration, title: $title, track: $track, fileExtension: $fileExtension, isAlarm: $isAlarm, isAudioBook: $isAudioBook, isMusic: $isMusic, isNotification: $isNotification, isPodcast: $isPodcast, isRingtone: $isRingtone)';
  }

  factory SongEntity.fromApiMap(Map<String, dynamic> map) {
    return SongEntity(
      id: map['id'] as int,
      data: map['data'] as String,
      albumArt: map['albumArt'] as String,
      albumArtUrl: map['albumArtUrl'] != null
          ? "${ApiEndpoints.baseImageUrl}${map['albumArtUrl']}"
          : null,
      serverUrl: map['serverUrl'] as String,
      uri: map['uri'] != null ? map['uri'] as String : null,
      displayName: map['displayName'] as String,
      displayNameWOExt: map['displayNameWOExt'] as String,
      size: map['size'] as int,
      album: map['album'] != null ? map['album'] as String : null,
      albumId: map['albumId'] != null ? map['albumId'] as String : null,
      artist: map['artist'] != null ? map['artist'] as String : null,
      artistId: map['artistId'] != null ? map['artistId'] as String : null,
      genre: map['genre'] != null ? map['genre'] as String : null,
      genreId: map['genreId'] != null ? map['genreId'] as String : null,
      bookmark: map['bookmark'] != null ? map['bookmark'] as int : null,
      composer: map['composer'] != null ? map['composer'] as String : null,
      dateAdded: map['dateAdded'] != null ? map['dateAdded'] as int : null,
      dateModified:
          map['dateModified'] != null ? map['dateModified'] as int : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
      title: map['title'] as String,
      track: map['track'] != null ? map['track'] as int : null,
      fileExtension: map['fileExtension'] as String,
      isAlarm: map['isAlarm'] != null ? map['isAlarm'] as bool : null,
      isAudioBook:
          map['isAudioBook'] != null ? map['isAudioBook'] as bool : null,
      isMusic: map['isMusic'] != null ? map['isMusic'] as bool : null,
      isNotification:
          map['isNotification'] != null ? map['isNotification'] as bool : null,
      isPodcast: map['isPodcast'] != null ? map['isPodcast'] as bool : null,
      isRingtone: map['isRingtone'] as bool,
      isPublic: map['isPublic'] != null ? map['isPublic'] as bool : null,
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

  Map<String, dynamic> toApiMap() {
    return <String, dynamic>{
      'id': id,
      'data': data,
      'serverUrl': serverUrl,
      'uri': uri,
      'displayName': displayName,
      'displayNameWOExt': displayNameWOExt,
      'size': size,
      'album': album,
      'albumId': albumId,
      'artist': artist,
      'artistId': artistId,
      'genre': genre,
      'genreId': genreId,
      'bookmark': bookmark,
      'composer': composer,
      'dateAdded': dateAdded,
      'dateModified': dateModified,
      'duration': duration,
      'title': title,
      'track': track,
      'fileExtension': fileExtension,
      'isAlarm': isAlarm,
      'isAudioBook': isAudioBook,
      'isMusic': isMusic,
      'isNotification': isNotification,
      'isPodcast': isPodcast,
      'isRingtone': isRingtone,
      'albumArt': albumArt,
      'albumArtUrl': albumArtUrl!.replaceAll("http://192.168.0.107:3001", ''),
      'isPublic': isPublic,
    };
  }
}

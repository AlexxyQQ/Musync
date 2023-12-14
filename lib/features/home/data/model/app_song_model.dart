import 'dart:convert';

import 'package:musync/core/utils/song_model_map_converter.dart';
import 'package:musync/features/home/data/model/hive/song_hive_model.dart';
import 'package:on_audio_query_platform_interface/src/models/song_model.dart';

import '../../../../config/constants/api/api_endpoints.dart';
import '../../domain/entity/song_entity.dart';

class AppSongModel extends SongEntity {
  const AppSongModel({
    required int id,
    required String data,
    required String? serverUrl,
    required String? uri,
    required String displayName,
    required String displayNameWOExt,
    required int size,
    required String? album,
    required String? albumId,
    required String? artist,
    required String? artistId,
    required String? genre,
    required String? genreId,
    required int? bookmark,
    required String? composer,
    required int? dateAdded,
    required int? dateModified,
    required int? duration,
    required String title,
    required int? track,
    required String fileExtension,
    required bool? isAlarm,
    required bool? isAudioBook,
    required bool? isMusic,
    required bool? isNotification,
    required bool? isPodcast,
    required bool isRingtone,
    required String albumArt,
    required String? albumArtUrl,
    required bool? isPublic,
  }) : super(
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

  factory AppSongModel.fromModelMap(Map<String, dynamic> map) {
    return AppSongModel(
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

  factory AppSongModel.fromJson(String source) =>
      AppSongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppSongModel Details:\n'
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

  factory AppSongModel.fromMap(Map<String, dynamic> map) {
    return AppSongModel(
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
  static AppSongModel fromSongModel(SongModel songModel) {
    return AppSongModel.fromModelMap(convertMap(songModel.getMap));
  }

  static List<AppSongModel> fromListSongModel(List<SongModel> songModel) {
    return songModel.map((e) => fromSongModel(e)).toList();
  }

  static AppSongModel fromHiveModel(SongHiveModel hiveSong) {
    return AppSongModel.fromMap(hiveSong.toMap());
  }

  static List<AppSongModel> fromListHiveModel(List<SongHiveModel> hiveSongs) {
    return hiveSongs.map((e) => fromHiveModel(e)).toList();
  }
}

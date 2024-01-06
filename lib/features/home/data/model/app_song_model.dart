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
    String? serverUrl,
    String? uri,
    required String displayName,
    required String displayNameWOExt,
    required int size,
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
    required String title,
    int? track,
    required String fileExtension,
    bool? isAlarm,
    bool? isAudioBook,
    bool? isMusic,
    bool? isNotification,
    bool? isPodcast,
    required bool isRingtone,
    String? albumArt,
    String? albumArtUrl,
    bool? isPublic,
    String? lyrics,
    required bool isFavorite,
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
          lyrics: lyrics,
          isFavorite: isFavorite,
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
      albumArt: map['album_art'] != null ? map['album_art'] as String : '',
      albumArtUrl:
          map['album_art_url'] != null ? map['album_art_url'] as String : null,
      isPublic: map['is_public'] != null ? map['is_public'] as bool : null,
      lyrics: map['lyrics'] != null ? map['lyrics'] as String : null,
      isFavorite:
          map['is_favorite'] != null ? map['is_favorite'] as bool : false,
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
        '  - Album Art: $albumArt\n'
        '  - Album Art URL: $albumArtUrl\n'
        '  - Is Public: $isPublic\n'
        '  - Lyrics: $lyrics\n'
        '  - Is Favorite: $isFavorite\n'
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
      lyrics: map['lyrics'] != null ? map['lyrics'] as String : null,
      isFavorite:
          map['is_favorite'] != null ? map['is_favorite'] as bool : false,
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
        lyrics,
        isFavorite,
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

  factory AppSongModel.fromEntity(SongEntity songEntity) {
    return AppSongModel(
      id: songEntity.id,
      data: songEntity.data,
      serverUrl: songEntity.serverUrl,
      uri: songEntity.uri,
      displayName: songEntity.displayName,
      displayNameWOExt: songEntity.displayNameWOExt,
      size: songEntity.size,
      album: songEntity.album,
      albumId: songEntity.albumId,
      artist: songEntity.artist,
      artistId: songEntity.artistId,
      genre: songEntity.genre,
      genreId: songEntity.genreId,
      bookmark: songEntity.bookmark,
      composer: songEntity.composer,
      dateAdded: songEntity.dateAdded,
      dateModified: songEntity.dateModified,
      duration: songEntity.duration,
      title: songEntity.title,
      track: songEntity.track,
      fileExtension: songEntity.fileExtension,
      isAlarm: songEntity.isAlarm,
      isAudioBook: songEntity.isAudioBook,
      isMusic: songEntity.isMusic,
      isNotification: songEntity.isNotification,
      isPodcast: songEntity.isPodcast,
      isRingtone: songEntity.isRingtone,
      albumArt: songEntity.albumArt,
      albumArtUrl: songEntity.albumArtUrl,
      isPublic: songEntity.isPublic,
      lyrics: songEntity.lyrics,
      isFavorite: songEntity.isFavorite,
    );
  }
}

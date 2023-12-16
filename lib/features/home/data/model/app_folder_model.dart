import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:musync/features/home/data/model/hive/folder_hive_model.dart';

import '../../domain/entity/folder_entity.dart';
import '../../domain/entity/song_entity.dart';

class AppFolderModel extends FolderEntity {
  AppFolderModel({
    required String path,
    required String folderName,
    required int numberOfSongs,
    required List<SongEntity>? songs,
  }) : super(
          path: path,
          folderName: folderName,
          numberOfSongs: numberOfSongs,
          songs: songs,
        );

  factory AppFolderModel.fromMap(Map<String, dynamic> map) {
    return AppFolderModel(
      path: map['path'] ?? '',
      folderName: map['folder_name'] ?? '',
      numberOfSongs: map['number_of_songs']?.toInt() ?? 0,
      songs: map['songs'] != null
          ? List<SongEntity>.from(
              map['songs']?.map(
                (x) => SongEntity.fromMap(x),
              ),
            )
          : null,
    );
  }

  factory AppFolderModel.fromJson(String source) =>
      AppFolderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppFolderModel Details:\n'
        '  - Path: $path\n'
        '  - Folder Name: $folderName\n'
        '  - Number of Songs: $numberOfSongs\n'
        '  - Songs: ${songs?.join(", ") ?? "None"}'; // Assuming songs is a list, joined with a comma for better readability
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppFolderModel &&
        other.path == path &&
        other.folderName == folderName &&
        other.numberOfSongs == numberOfSongs &&
        listEquals(other.songs, songs);
  }

  @override
  int get hashCode {
    return path.hashCode ^
        folderName.hashCode ^
        numberOfSongs.hashCode ^
        songs.hashCode;
  }

  static List<AppFolderModel> fromListofPaths(List<String> paths) {
    return paths
        .map(
          (e) => AppFolderModel(
            path: e,
            folderName: e.split('/').last,
            numberOfSongs: 0,
            songs: null,
          ),
        )
        .toList();
  }

  static AppFolderModel fromListofHiveModel(FolderHiveModel hiveFolder) {
    return AppFolderModel.fromMap(hiveFolder.toMap());
  }

  static List<AppFolderModel> fromListHiveModel(
    List<FolderHiveModel> hiveArtists,
  ) {
    return hiveArtists.map((e) => fromListofHiveModel(e)).toList();
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:musync/features/home/domain/entity/song_entity.dart';

class FolderEntity {
  final String path;
  final String folderName;
  final int numberOfSongs;
  final List<SongEntity>? songs;
  FolderEntity({
    required this.path,
    required this.folderName,
    required this.numberOfSongs,
    this.songs,
  });

  FolderEntity copyWith({
    String? path,
    String? folderName,
    int? numberOfSongs,
    List<SongEntity>? songs,
  }) {
    return FolderEntity(
      path: path ?? this.path,
      folderName: folderName ?? this.folderName,
      numberOfSongs: numberOfSongs ?? this.numberOfSongs,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'path': path});
    result.addAll({'folder_name': folderName});
    result.addAll({'number_of_songs': numberOfSongs});
    if (songs != null) {
      result.addAll({'songs': songs!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory FolderEntity.fromMap(Map<String, dynamic> map) {
    return FolderEntity(
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

  String toJson() => json.encode(toMap());

  factory FolderEntity.fromJson(String source) =>
      FolderEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FolderEntity Details:\n'
        '  - Path: $path\n'
        '  - Folder Name: $folderName\n'
        '  - Number of Songs: $numberOfSongs\n'
        '  - Songs: ${songs?.join(", ") ?? "None"}'; // Assuming songs is a list, joined with a comma for better readability
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FolderEntity &&
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
}

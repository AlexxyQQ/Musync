import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:musync/config/constants/hive/hive_tabel_constant.dart';
import 'package:musync/features/home/data/model/app_folder_model.dart';
import 'package:musync/features/home/data/model/app_song_model.dart';

part 'folder_hive_model.g.dart';

@HiveType(
  typeId: HiveTableConstant.folderTableId,
)
class FolderHiveModel {
  @HiveField(0)
  final String path;

  @HiveField(1)
  final String folderName;

  @HiveField(2)
  final String? numberOfSongs;

  @HiveField(3)
  final List<AppSongModel>? songs;
  FolderHiveModel({
    required this.path,
    required this.folderName,
    this.numberOfSongs,
    this.songs,
  });

  factory FolderHiveModel.fromMap(Map<String, dynamic> map) {
    return FolderHiveModel(
      path: map['path'] ?? '',
      folderName: map['folderName'] ?? '',
      numberOfSongs: map['numberOfSongs'],
      songs: map['songs'] != null
          ? List<AppSongModel>.from(
              map['songs']?.map(
                (x) => AppSongModel.fromMap(
                  x,
                ),
              ),
            )
          : null,
    );
  }

  factory FolderHiveModel.fromJson(String source) =>
      FolderHiveModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'path': path});
    result.addAll({'folder_name': folderName});
    if (numberOfSongs != null) {
      result.addAll({'number_of_songs': numberOfSongs});
    }
    if (songs != null) {
      result.addAll({'songs': songs!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  static FolderHiveModel fromAppFolderModel(AppFolderModel model) {
    return FolderHiveModel.fromMap(model.toMap());
  }

  static List<FolderHiveModel> fromAppFolderModelList(
    List<AppFolderModel> models,
  ) {
    return models.map((e) => fromAppFolderModel(e)).toList();
  }

  @override
  String toString() {
    return 'FolderHiveModel Details:\n'
        '  - Path: $path\n'
        '  - Folder Name: $folderName\n'
        '  - Number of Songs: $numberOfSongs\n'
        '  - Songs: ${songs?.join(", ") ?? "None"}'; // Assuming songs is a list, joined with a comma for better readability
  }

  FolderHiveModel copyWith({
    String? path,
    String? folderName,
    String? numberOfSongs,
    List<AppSongModel>? songs,
  }) {
    return FolderHiveModel(
      path: path ?? this.path,
      folderName: folderName ?? this.folderName,
      numberOfSongs: numberOfSongs ?? this.numberOfSongs,
      songs: songs ?? this.songs,
    );
  }

  String toJson() => json.encode(toMap());
}

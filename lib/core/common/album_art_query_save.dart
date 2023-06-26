import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class AlbumArtQuerySave {
  final OnAudioQuery audioQuery;

  const AlbumArtQuerySave({required this.audioQuery});

  Future<String> saveAlbumArt({
    required int id,
    required ArtworkType type,
    required String fileName,
    int size = 200,
    int quality = 100,
    ArtworkFormat format = ArtworkFormat.PNG,
  }) async {
    final String tempPath = await path_provider
        .getApplicationDocumentsDirectory()
        .then((value) => value.path);
    final File file = File('$tempPath/$fileName.png');

    if (!await file.exists()) {
      await file.create();
      final Uint8List? image = await audioQuery.queryArtwork(
        id,
        type,
        format: format,
        size: size,
        quality: quality,
      );
      if (image != null) {
        file.writeAsBytesSync(image);
      }
    }
    return file.path;
  }

  Future<Uint8List?> artwork(int id) async {
    return await audioQuery.queryArtwork(
      id,
      ArtworkType.AUDIO,
      size: 200,
      format: ArtworkFormat.PNG,
    );
  }
}

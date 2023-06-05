import 'dart:io';

import 'package:flutter/material.dart';
import 'package:musync/core/repositories/music_repositories.dart';

import 'package:on_audio_query/on_audio_query.dart';

class ArtWorkImage extends StatelessWidget {
  ArtWorkImage({
    super.key,
    required this.id,
    required this.filename,
    this.height = 50.0,
    this.width = 50.0,
    this.borderRadius,
  });
  final int id;
  final String filename;
  int size = 200;
  int quality = 100;
  ArtworkFormat format = ArtworkFormat.JPEG;
  ArtworkType artworkType = ArtworkType.AUDIO;
  BorderRadius? borderRadius;
  Clip clipBehavior = Clip.antiAlias;
  BoxFit fit = BoxFit.cover;
  FilterQuality filterQuality = FilterQuality.low;
  double height;
  double width;
  double elevation = 5;
  ImageRepeat imageRepeat = ImageRepeat.noRepeat;
  bool gaplessPlayback = true;
  Widget? errorWidget;
  Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: MusicRepository().saveAlbumArt(
        id: id,
        type: ArtworkType.AUDIO,
        fileName: filename,
      ),
      builder: (context, item) {
        if (item.data != null &&
            item.data!.isNotEmpty &&
            File(item.data!).existsSync() &&
            File(item.data!).lengthSync() > 0) {
          final File file = File(item.data!);
          return Card(
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(7.0),
            ),
            clipBehavior: clipBehavior,
            child: Image(
              image: FileImage(file),
              gaplessPlayback: gaplessPlayback,
              repeat: imageRepeat,
              width: width,
              height: height,
              fit: fit,
              filterQuality: filterQuality,
              errorBuilder: (context, exception, stackTrace) {
                return errorWidget ??
                    Image(
                      fit: BoxFit.cover,
                      height: height,
                      width: width,
                      image: const AssetImage('assets/splash_screen/icon.png'),
                    );
              },
            ),
          );
        }
        return Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7.0),
          ),
          clipBehavior: clipBehavior,
          child: placeholder ??
              Image(
                fit: BoxFit.cover,
                height: height,
                width: width,
                image: const AssetImage('assets/splash_screen/icon.png'),
              ),
        );
      },
    );
  }
}

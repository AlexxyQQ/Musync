import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/features/home/data/repository/music_query_repositories.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtWorkImage extends StatelessWidget {
  const ArtWorkImage({
    Key? key,
    required this.id,
    required this.filename,
    this.height = 50.0,
    this.width = 50.0,
    this.borderRadius,
  }) : super(key: key);

  final int id;
  final String filename;
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: GetIt.instance<MusicQueryRepositoryImpl>().saveAlbumArt(
        id: id,
        type: ArtworkType.AUDIO,
        fileName: filename,
      ),
      builder: (context, snapshot) {
        final String? filePath = snapshot.data;

        Widget buildImageWidget() {
          if (filePath != null &&
              File(filePath).existsSync() &&
              File(filePath).lengthSync() > 0) {
            return Image.file(
              File(filePath),
              width: width,
              height: height,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
              errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
            );
          } else {
            return _buildPlaceholderWidget();
          }
        }

        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(7.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: buildImageWidget(),
        );
      },
    );
  }

  Widget _buildErrorWidget() {
    return Image.asset(
      'assets/splash_screen/icon.png',
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }

  Widget _buildPlaceholderWidget() {
    return Image.asset(
      'assets/splash_screen/icon.png',
      scale: 0.5,
      fit: BoxFit.cover,
      width: 198,
      height: 198,
    );
  }
}

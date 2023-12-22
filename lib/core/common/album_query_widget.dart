import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class SongArtWork extends StatefulWidget {
  const SongArtWork({
    super.key,
    required this.song,
    this.height = 50,
    this.width = 50,
    this.borderRadius = 12,
  });
  final double height;
  final double width;
  final double borderRadius;
  final SongEntity song;

  @override
  State<SongArtWork> createState() => _SongArtWorkState();
}

class _SongArtWorkState extends State<SongArtWork> {
  bool isNetworkImage = false;

  /// Checks if the `albumArt` of the song is a network image URL.
  ///
  /// This method checks whether the `albumArt` of the provided [widget.song]
  /// is a network image URL (starts with 'http'). If it is a network image,
  /// it sets [isNetworkImage] to true; otherwise, it sets it to false.
  void _networkImageChecker() {
    if ((widget.song.albumArt != null || widget.song.albumArt != '') &&
        widget.song.albumArt!.contains('http')) {
      isNetworkImage = true;
    } else if (widget.song.albumArt != null || widget.song.albumArt != '') {
      isNetworkImage = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _networkImageChecker();
  }

  @override
  Widget build(BuildContext context) {
    return isNetworkImage
        ? Container(
            height: widget.height.h,
            width: widget.width.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.song.albumArtUrl ?? '',
              height: widget.height.h,
              width: widget.width.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Image.asset(
                  'assets/splash_screen/icon.png',
                  fit: BoxFit.cover,
                );
              },
            ),
          )
        : Container(
            height: widget.height.h,
            width: widget.width.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              image: DecorationImage(
                image: Image.file(
                  File(widget.song.albumArt ?? ''),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/splash_screen/icon.png',
                      fit: BoxFit.cover,
                    );
                  },
                ).image,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}

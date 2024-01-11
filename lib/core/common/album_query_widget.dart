
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/primitive_colors.dart';
import 'package:musync/core/common/album_art_query_save.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/injection/app_injection_container.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveImage();
  }

  void saveImage() async {
    await AlbumArtQuerySave(audioQuery: get<OnAudioQuery>()).saveAlbumArt(
      id: widget.song.id,
      type: ArtworkType.AUDIO,
      fileName: widget.song.displayNameWOExt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: widget.song.id,
      artworkHeight: widget.height.h,
      artworkWidth: widget.width.w,
      artworkBorder: BorderRadius.circular(widget.borderRadius.r),
      nullArtworkWidget: const Icon(
        Icons.music_note_rounded,
        size: 40,
        color: PrimitiveColors.primary500,
      ),
      type: ArtworkType.AUDIO,
      errorBuilder: (p0, p1, p2) {
        return const Icon(
          Icons.music_note_rounded,
          color: PrimitiveColors.primary500,
        );
      },
    );
  }
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/core/utils/duration_foramttor_function.dart';
import 'package:musync/core/utils/extensions/duration_formattor_extension.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

class SongListTile extends StatefulWidget {
  final SongEntity song;
  final bool trailing;
  final Function()? onTap;
  const SongListTile({
    super.key,
    required this.song,
    this.trailing = false,
    this.onTap,
  });

  @override
  State<SongListTile> createState() => _SongListTileState();
}

class _SongListTileState extends State<SongListTile> {
  bool isNetworkImage = false;

  @override
  void initState() {
    super.initState();
    _networkImageChecker();
  }

  /// Checks if the `albumArt` of the song is a network image URL.
  ///
  /// This method checks whether the `albumArt` of the provided [widget.song]
  /// is a network image URL (starts with 'http'). If it is a network image,
  /// it sets [isNetworkImage] to true; otherwise, it sets it to false.
  void _networkImageChecker() {
    if ((widget.song.albumArt == null || widget.song.albumArt == '') &&
        widget.song.albumArt!.contains('http')) {
      isNetworkImage = true;
    } else if (widget.song.albumArt != null || widget.song.albumArt != '') {
      isNetworkImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      leading: isNetworkImage
          ? Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.song.albumArtUrl ?? '',
                width: 50,
                height: 50,
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
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
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
            ),
      title: Text(
        widget.song.displayNameWOExt,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(context).textTheme.mBM.copyWith(
              color: AppColors().onSurface,
            ),
      ),
      subtitle: Row(
        children: [
          Text(
            "${widget.song.artist}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.lBS.copyWith(
                  color: AppColors().onSurfaceVariant,
                ),
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            " - ${widget.song.duration.formatDuration()}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.lBS.copyWith(
                  color: AppColors().onSurfaceVariant,
                ),
          ),
        ],
      ),
      // trailing: widget.trailing
      //     ? IconButton(
      //         icon: Icon(
      //           Icons.more_vert,
      //           color: AppColors().onSurfaceVariant,
      //         ),
      //         onPressed: widget.onTap,
      //       )
      //     : null,

      trailing: IconButton(
        icon: Icon(
          Icons.more_vert,
          color: AppColors().onSurfaceVariant,
        ),
        onPressed: widget.onTap,
      ),
    );
  }
}

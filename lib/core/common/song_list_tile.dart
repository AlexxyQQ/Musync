import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
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
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      leading: SongArtWork(
        song: widget.song,
        borderRadius: 500,
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
      trailing: widget.trailing
          ? IconButton(
              icon: Icon(
                Icons.more_vert,
                color: AppColors().onSurfaceVariant,
              ),
              onPressed: widget.onTap,
            )
          : null,
    );
  }
}

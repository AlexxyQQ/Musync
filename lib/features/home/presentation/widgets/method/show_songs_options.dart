import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

void songOptions(SongEntity song, BuildContext context) {
  //  Show the bottom sheet
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 500.h,
        decoration: BoxDecoration(
          color: AppColors(inverseDarkMode: true).surfaceContainerHigh,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline_rounded,
                      color: AppColors().onSurfaceVariant,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Add to Playlist',
                      style: Theme.of(context).textTheme.mBM.copyWith(
                            color: AppColors().onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.queue_music_rounded,
                      color: AppColors().onSurfaceVariant,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Add to Queue',
                      style: Theme.of(context).textTheme.mBM.copyWith(
                            color: AppColors().onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors().onSurfaceVariant,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Play Next',
                      style: Theme.of(context).textTheme.mBM.copyWith(
                            color: AppColors().onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: AppColors().surfaceDim,
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.album_outlined,
                      color: AppColors().onSurfaceVariant,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Go to Album',
                      style: Theme.of(context).textTheme.mBM.copyWith(
                            color: AppColors().onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.person_3_outlined,
                      color: AppColors().onSurfaceVariant,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Go to Artist',
                      style: Theme.of(context).textTheme.mBM.copyWith(
                            color: AppColors().onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.folder_open_rounded,
                      color: AppColors().onSurfaceVariant,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Go to Folder',
                      style: Theme.of(context).textTheme.mBM.copyWith(
                            color: AppColors().onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: AppColors().surfaceDim,
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors().onSurfaceVariant,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Info',
                      style: Theme.of(context).textTheme.mBM.copyWith(
                            color: AppColors().onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_rounded,
                      color: AppColors().onSurfaceVariant,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Delete',
                      style: Theme.of(context).textTheme.mBM.copyWith(
                            color: AppColors().onSurface,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

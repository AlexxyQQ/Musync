import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musync/config/constants/global_constants.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';

void songOptions(SongEntity song, BuildContext context) {
  //  Show the bottom sheet
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 500.h,
        decoration: BoxDecoration(
          color: AppColors().surfaceContainerHigh,
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
              //? Add to Playlist
              GestureDetector(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.addOutlined,
                      width: 24.r,
                      color: AppColors().onSurface,
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
              //? Add to Queue
              GestureDetector(
                onTap: () {
                  BlocProvider.of<NowPlayingCubit>(context).addToQueue(song);
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.addQueueOutlined,
                      width: 24.r,
                      color: AppColors().onSurface,
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
              //? Play Next
              GestureDetector(
                onTap: () {
                  BlocProvider.of<NowPlayingCubit>(context).playNext(song);
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.curvedArrowRight,
                      width: 24.r,
                      color: AppColors().onSurface,
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
                color: AppColors().outline,
              ),
              //? Go to Album
              GestureDetector(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.albumOutlined,
                      width: 24.r,
                      color: AppColors().onSurface,
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
              //? Go to Artist
              GestureDetector(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.artistOutlined,
                      width: 24.r,
                      color: AppColors().onSurface,
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
              //? Go to Folder
              GestureDetector(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.musicFolderOutlined,
                      width: 24.r,
                      color: AppColors().onSurface,
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
                color: AppColors().outline,
              ),
              //? Info
              GestureDetector(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.infoOutlined,
                      width: 24.r,
                      color: AppColors().onSurface,
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
              //? Delete
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.deleteOutlined,
                      width: 24.r,
                      color: AppColors().onSurface,
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

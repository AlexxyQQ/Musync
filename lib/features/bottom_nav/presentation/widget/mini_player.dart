import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/constants/colors/primitive_colors.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10.w,
      height: 60.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: PrimitiveColors.grey900,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cover and Name
                Row(
                  children: [
                    // Album Cover
                    SongArtWork(
                      song: BlocProvider.of<QueryCubit>(context)
                          .state
                          .songs
                          .first,
                      height: 44.h,
                      width: 44.w,
                      borderRadius: 8.r,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    //  Song Title
                    SizedBox(
                      width: 150.w,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "BlocProvider.of<QueryCubit>(context)asdasssssssssssd",
                        style: Theme.of(context).textTheme.mBS.copyWith(
                              color: AppDarkColor.onBackground,
                            ),
                      ),
                    ),
                  ],
                ),
                // Icons
                Row(
                  children: [
                    // Play
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.play,
                        color: AppDarkColor.onBackground,
                        size: 18.r,
                      ),
                    ),
                    // Next
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.forward_end_alt,
                        color: AppDarkColor.onBackground,
                        size: 18.r,
                      ),
                    ),
                    // Repeat
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.repeat,
                        color: AppDarkColor.onBackground,
                        size: 18.r,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          //Prograss Bar
          Positioned(
            bottom: 0,
            left: 4.w,
            child: Container(
              height: 4.h,
              width: MediaQuery.of(context).size.width - 30.w,
              decoration: BoxDecoration(
                color: PrimitiveColors.primary300,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musync/config/constants/global_constants.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_state.dart';

class AudioControllers extends StatefulWidget {
  const AudioControllers({super.key});

  @override
  State<AudioControllers> createState() => _AudioControllersState();
}

class _AudioControllersState extends State<AudioControllers> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //? Shuffle
            IconButton(
              onPressed: () {
                BlocProvider.of<NowPlayingCubit>(context).shuffle();
              },
              icon: SvgPicture.asset(
                AppIcons.shuffle,
                height: 28.r,
                color: state.isShuffle
                    ? PrimitiveColors.primary500
                    : PrimitiveColors.grey400,
              ),
            ),
            //? Previous
            IconButton(
              onPressed: () {
                BlocProvider.of<NowPlayingCubit>(context).previous();
              },
              icon: SvgPicture.asset(
                AppIcons.previousFilled,
                height: 28.r,
              ),
            ),
            //? Play/Pause
            Container(
              decoration: BoxDecoration(
                color: PrimitiveColors.primary500,
                borderRadius: BorderRadius.circular(50.r),
              ),
              height: 80.h,
              width: 80.w,
              child: IconButton(
                onPressed: () {
                  if (state.isPlaying) {
                    BlocProvider.of<NowPlayingCubit>(context).pause();
                  } else {
                    BlocProvider.of<NowPlayingCubit>(context).play();
                  }
                },
                icon: SvgPicture.asset(
                  state.isPlaying ? AppIcons.playFilled : AppIcons.pause,
                  height: 28.r,
                  color: AppDarkColor.onPrimary,
                ),
              ),
            ),
            //? Next
            IconButton(
              onPressed: () {
                BlocProvider.of<NowPlayingCubit>(context).next();
              },
              icon: SvgPicture.asset(
                AppIcons.nextFilled,
                height: 28.r,
              ),
            ),
            //? Repeat
            IconButton(
              onPressed: () {
                BlocProvider.of<NowPlayingCubit>(context).repeat();
              },
              icon: state.isRepeat
                  ? SvgPicture.asset(
                      AppIcons.repeatOne,
                      height: 28.r,
                    )
                  : SvgPicture.asset(
                      AppIcons.repeatAll,
                      height: 28.r,
                    ),
            ),
          ],
        );
      },
    );
  }
}

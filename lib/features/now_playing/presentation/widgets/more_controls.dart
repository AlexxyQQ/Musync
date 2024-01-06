import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musync/config/constants/colors/primitive_colors.dart';
import 'package:musync/config/constants/global_constants.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/auth/presentation/cubit/authentication_cubit.dart';

class MoreControls extends StatelessWidget {
  const MoreControls({
    super.key,
    required this.setScroll,
  });
  final void Function() setScroll;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //? Currently Playing Device
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.devices,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              'Living Room',
              style: Theme.of(context).textTheme.mBS.copyWith(
                    color: PrimitiveColors.primary500,
                    letterSpacing: 1,
                  ),
            ),
          ],
        ),
        //? Share and Queue
        Row(
          children: [
            //? Share
            (BlocProvider.of<AuthenticationCubit>(context).state.loggedUser !=
                    null)
                ? IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppIcons.share,
                      color: AppColors().onBackground,
                      height: 18.r,
                    ),
                  )
                : IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      BlocProvider.of<NowPlayingCubit>(context)
                              .state
                              .currentSong!
                              .isFavorite
                          ? AppIcons.heartFilled
                          : AppIcons.heartOutlined,
                      color: AppColors().onBackground,
                      height: 18.r,
                    ),
                  ),
            SizedBox(width: 4.w),
            IconButton(
              onPressed: () {
                setScroll();
              },
              icon: const Icon(
                Icons.queue_music,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

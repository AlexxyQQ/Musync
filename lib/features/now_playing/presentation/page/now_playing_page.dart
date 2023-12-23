import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Animated Navigation to new page
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_downward_rounded,
          ),
        ),
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'NOW PLAYING',
              style: Theme.of(context).textTheme.lBM.copyWith(
                    color: AppColors().onBackground,
                  ),
            ),
            Text(
              'Song Title',
              style: Theme.of(context).textTheme.mBS.copyWith(
                    color: AppColors().onBackground,
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // songOptions(song, context);
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            // Album Cover
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 44.h,
              ),
              child: Placeholder(
                fallbackHeight: 300.h,
                fallbackWidth: MediaQuery.of(context).size.width,
              ),
            ),
            // SongArtWork(
            //   song: BlocProvider.of<QueryCubit>(context)
            //       .state
            //       .songs
            //       .first,
            //   height: 44.h,
            //   width: 44.w,
            //   borderRadius: 8.r,
            // ),
            SizedBox(
              height: 8.h,
            ),
            // Song Title
            Text(
              'Song Title',
              style: Theme.of(context).textTheme.bBL.copyWith(
                    color: AppColors().onBackground,
                  ),
            ),
            SizedBox(
              height: 8.h,
            ),
            // Artist Name
            Text(
              'Artist Name',
              style: Theme.of(context).textTheme.mBM.copyWith(
                    color: AppColors(inverseDarkMode: true).surfaceDim,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

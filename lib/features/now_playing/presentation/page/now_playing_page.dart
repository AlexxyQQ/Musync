import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_cubit.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  late SongEntity? song;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    song = BlocProvider.of<NowPlayingCubit>(context).state.currentSong;
  }

  @override
  Widget build(BuildContext context) {
    if (song == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
              song!.title,
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
              child: SongArtWork(
                song: song!,
                height: 300.h,
                width: MediaQuery.of(context).size.width,
                borderRadius: 8.r,
              ),
            ),

            SizedBox(
              height: 8.h,
            ),
            // Song Title
            Text(
              song!.title,
              style: Theme.of(context).textTheme.bBL.copyWith(
                    color: AppColors().onBackground,
                  ),
            ),
            SizedBox(
              height: 8.h,
            ),
            // Artist Name
            Text(
              '${song!.artist}',
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

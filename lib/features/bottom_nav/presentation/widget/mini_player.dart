import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/constants/colors/primitive_colors.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/bottom_nav/presentation/widget/duration_slider.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:musync/features/home/presentation/widgets/method/extract_album_cover_color.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_cubit.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_state.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  Color albumArtColor = PrimitiveColors.grey900;
  Color textColor = AppDarkColor.onSurface;

  @override
  void initState() {
    super.initState();
  }

  void getAlbumArtColor(String filePath) async {
    extractAlbumArtColor(filePath).then((value) {
      setState(() {
        albumArtColor = value[0];
        textColor = value[1];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        if (state.currentSong == null) {
          return Container();
        }

        getAlbumArtColor(state.currentSong!.albumArt ?? "null");

        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.nowPlayingRoute);
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 10.w,
            height: 60.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: albumArtColor,
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
                            song: state.currentSong!,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  state.currentSong!.title,
                                  style:
                                      Theme.of(context).textTheme.mBS.copyWith(
                                            color: textColor,
                                            letterSpacing: 0.8,
                                          ),
                                ),
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  "${state.currentSong!.artist}",
                                  style:
                                      Theme.of(context).textTheme.lC.copyWith(
                                            color: textColor,
                                            letterSpacing: 1,
                                          ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Icons
                      Row(
                        children: [
                          // Play
                          IconButton(
                            onPressed: () {
                              if (state.isPlaying) {
                                context.read<NowPlayingCubit>().pause();
                              } else {
                                context.read<NowPlayingCubit>().play();
                              }
                            },
                            icon: Icon(
                              state.isPlaying
                                  ? CupertinoIcons.pause
                                  : CupertinoIcons.play,
                              color: textColor,
                              size: 18.r,
                            ),
                          ),
                          // Next
                          IconButton(
                            onPressed: () {
                              context.read<NowPlayingCubit>().next();
                              BlocProvider.of<QueryCubit>(context)
                                  .updateRecentlyPlayedSongs(
                                song: state.currentSong!,
                              );
                            },
                            icon: Icon(
                              CupertinoIcons.forward_end_alt,
                              color: textColor,
                              size: 18.r,
                            ),
                          ),
                          // Share
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_outlined,
                              color: textColor,
                              size: 18.r,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //Prograss Bar
                Positioned(
                  bottom: -18.h,
                  left: -20.w,
                  width: 416.w,
                  child: DurationSlider(
                    height: 6.h,
                    activeColor: PrimitiveColors.primary500,
                    thumbRadius: 0,
                    overlayRadius: 20.r,
                    inactiveColor: PrimitiveColors.primary900,
                    audioPlayer: state.audioPlayer!,
                    duration: false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

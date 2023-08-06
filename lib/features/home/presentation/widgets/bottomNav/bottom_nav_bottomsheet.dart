import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/features/nowplaying/presentation/state/now_playing_state.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:musync/features/nowplaying/presentation/widgets/audio_controlls.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingViewModel, NowPlayingState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.nowPlayingRoute,
              arguments: <String, dynamic>{
                'songs': state.queue,
                'index': state.currentIndex,
              },
            );
          },
          child: Container(
            height: 110,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: KColors.offBlackColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Song Image
                    Hero(
                      tag: 'albumArt',
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: KColors.todoColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state.currentSong.albumArtUrl == null ||
                                state.currentSong.albumArtUrl == ''
                            ? QueryArtworkWidget(
                                artworkBorder: BorderRadius.circular(10),
                                id: state.currentSong.id,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note_rounded,
                                  size: 40,
                                  color: KColors.accentColor,
                                ),
                                type: ArtworkType.AUDIO,
                                errorBuilder: (p0, p1, p2) {
                                  return const Icon(
                                    Icons.music_note_rounded,
                                    color: KColors.accentColor,
                                  );
                                },
                              )
                            : QueryArtworkFromApi(
                                borderRadius: BorderRadius.circular(10),
                                data: state.queue,
                                index: state.currentIndex,
                              ),
                      ),
                    ),
                    // Song Title
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            state.currentSong.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            ("${state.currentSong.artist}"),
                            softWrap: true,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: KColors.greyColor),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Share Button
                    IconButton(
                      icon: const Icon(Icons.share_rounded),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    // Next Button
                    IconButton(
                      icon: const Icon(Icons.skip_next_rounded, size: 30),
                      color: Colors.white,
                      onPressed: () async {
                        await context.read<NowPlayingViewModel>().next();
                      },
                    ),

                    // Play/Pause Button
                    IconButton(
                      icon: Icon(
                        (state.isPaused ||
                                state.isStopped) //* if paused or stopped
                            ? Icons.play_arrow_rounded
                            : Icons.pause_rounded,
                        color: KColors.accentColor,
                        size: 30,
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        (state.isPaused || state.isStopped)
                            ? await context.read<NowPlayingViewModel>().play()
                            : await context.read<NowPlayingViewModel>().pause();
                      },
                    ),
                  ],
                ),
                // Progress Bar
                DurationSlider(
                  height: 4,
                  activeColor: KColors.accentColor,
                  thumbRadius: 6,
                  overlayRadius: 20,
                  inactiveColor: KColors.greyColor,
                  audioPlayer: state.audioPlayer,
                  duration: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/nowplaying2/presentation/state/now_playing_state.dart';
import 'package:musync/features/nowplaying2/presentation/view_model/now_playing_view_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueueView extends StatelessWidget {
  final List<SongEntity> songList;
  const QueueView({super.key, required this.songList});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<NowPlayingViewModel, NowPlayingState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: isDark ? KColors.offBlackColor : KColors.offWhiteColor,
          ),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(' Q U E U E'),
            ),
            body: Scrollbar(
              controller: controller,
              radius: const Radius.circular(10),
              thickness: 10,
              interactive: true,
              child: ListView.builder(
                itemCount: songList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: state.queue[index].albumArtUrl == null ||
                              state.queue[index].albumArtUrl == ''
                          ? QueryArtworkWidget(
                              id: state.queue[index].id,
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
                              data: state.queue,
                              index: index,
                            ),
                    ),
                    title: Text(
                      state.queue[index].title,
                      style: TextStyle(
                        color: state.currentIndex == index
                            ? KColors.accentColor
                            : isDark
                                ? KColors.offWhiteColor
                                : KColors.offBlackColor,
                      ),
                    ),
                    subtitle: Text(
                      state.queue[index].artist!,
                      style: TextStyle(
                        color: state.currentIndex == index
                            ? KColors.accentColor
                            : isDark
                                ? KColors.offWhiteColor
                                : KColors.offBlackColor,
                      ),
                    ),
                    onTap: () {
                      context.read<NowPlayingViewModel>().playAll(
                            songs: songList,
                            index: index,
                          );
                      // Navigator.pushNamed(context, Routers.nowPlaying);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

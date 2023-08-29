import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/state/music_query_state.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BrowseView extends StatefulWidget {
  const BrowseView({super.key});

  @override
  State<BrowseView> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView> {
  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final songNameColor = isDark ? KColors.whiteColor : KColors.blackColor;
    final songArtistColor =
        isDark ? KColors.offWhiteColor : KColors.offBlackColor;
    final ScrollController controller = ScrollController();

    return RefreshIndicator(
      onRefresh: () async {
        await BlocProvider.of<MusicQueryViewModel>(context).getAllPublicSongs();
      },
      child: BlocBuilder<MusicQueryViewModel, MusicQueryState>(
        builder: (context, state) {
          final List<SongEntity> song = state.publicSongs;
          if (song.isEmpty) {
            return const Center(
              child: Text("No songs found"),
            );
          }
          return SizedBox(
            height: mqSize.height,
            width: mqSize.width,
            child: Scrollbar(
              controller: controller,
              child: ListView.builder(
                controller: controller,
                itemCount: song.length,
                itemBuilder: (context, index) {
                  final ms = song[index].duration!;
                  final duration = Duration(milliseconds: ms);
                  final minutes = duration.inMinutes;
                  final seconds = duration.inSeconds.remainder(60);

                  return InkWell(
                    onTap: () async {
                      final nav = Navigator.of(context);
                      await BlocProvider.of<NowPlayingViewModel>(
                        context,
                      ).playAll(
                        songs: song,
                        index: index,
                      );
                      nav.pushNamed(
                        AppRoutes.nowPlayingRoute,
                        arguments: {
                          "songs": song,
                          "index": index,
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 5,
                      ),
                      child: ListTile(
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: song[index].albumArtUrl == null ||
                                  song[index].albumArtUrl == ''
                              ? QueryArtworkWidget(
                                  id: song[index].id,
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
                                  data: song,
                                  index: index,
                                ),
                        ),
                        title: SizedBox(
                          width: mqSize.width * 0.7,
                          child: Text(
                            song[index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: songNameColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            if (song[index].serverUrl != '' &&
                                song[index].serverUrl != null)
                              const Icon(
                                Icons.cloud,
                                size: 20,
                                color: KColors.accentColor,
                              ),
                            const SizedBox(width: 5),
                            RichText(
                              text: TextSpan(
                                text:
                                    '${song[index].artist} • ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  color: songArtistColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

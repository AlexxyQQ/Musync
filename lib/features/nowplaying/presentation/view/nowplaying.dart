import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/coreold/repositories/audio_player_repository.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/nowplaying/presentation/view/queue_view.dart';
import 'package:musync/features/nowplaying/presentation/widgets/audio_controlls.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key, required this.songList, required this.index});

  final List<SongEntity> songList;
  final int index;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    bool isTablet =
        MediaQuery.of(context).size.width > GlobalConstants.tabletSize.width;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return isTablet
        ? isPortrait
            ? NowPlayingPhone(
                isDark: isDark,
                isTablet: isTablet,
                isPortrait: isPortrait,
                songs: widget.songList,
                index: widget.index,
              )
            : NowPlayingTablet(
                isDark: isDark,
                isTablet: isTablet,
                isPortrait: isPortrait,
                songs: widget.songList,
                index: widget.index,
              )
        : isPortrait
            ? NowPlayingPhone(
                isDark: isDark,
                isTablet: isTablet,
                isPortrait: isPortrait,
                songs: widget.songList,
                index: widget.index,
              )
            : NowPlayingTablet(
                isDark: isDark,
                isTablet: isTablet,
                isPortrait: isPortrait,
                songs: widget.songList,
                index: widget.index,
              );
  }
}

class NowPlayingPhone extends StatelessWidget {
  const NowPlayingPhone({
    super.key,
    required this.isDark,
    required this.isTablet,
    required this.isPortrait,
    required this.songs,
    required this.index,
  });

  final bool isDark;
  final bool isTablet;
  final bool isPortrait;
  final List<SongEntity> songs;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
        title: const Text(
          'Name of the Folder/Playlist playing from',
        ),
        // Back Button
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
        ),
        actions: [
          // More Options Button
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      // Body
      body: Container(
        color: isDark ? KColors.blackColor : KColors.whiteColor,
        child: Column(
          children: [
            // Album Art
            Expanded(
              child: Hero(
                tag: 'albumArt',
                child: Align(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isDark
                              ? KColors.offBlackColor
                              : KColors.offBlackColor,
                        ),
                        // Add Album Art Here
                        child: songs[index].albumArtUrl == null ||
                                songs[index].albumArtUrl == ''
                            ? QueryArtworkWidget(
                                id: songs[index].id,
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
                                data: songs,
                                index: index,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Song Title and Artist
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        songs[index].title,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        ("• ${songs[index].artist} •"),
                        softWrap: true,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: KColors.greyColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Duration Slider
            DurationSlider(
              height: 4,
              activeColor: isDark ? KColors.accentColor : KColors.blackColor,
              thumbRadius: 6,
              overlayRadius: 20,
              inactiveColor: KColors.greyColor,
            ),
            // Audio Controls
            AudioControlls(
              audioController: GetIt.I<AudioPlayerRepository>().player,
              processingState:
                  GetIt.I<AudioPlayerRepository>().player.processingState,
            ),
            // More Controls
            MoreControlls(
              bottomSheetCallback: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  useSafeArea: true,
                  enableDrag: true,
                  builder: (context) => QueueView(
                    songList: songs,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class NowPlayingTablet extends StatelessWidget {
  const NowPlayingTablet({
    super.key,
    required this.isDark,
    required this.isTablet,
    required this.isPortrait,
    required this.songs,
    required this.index,
  });

  final bool isDark;
  final bool isTablet;
  final bool isPortrait;
  final List<SongEntity> songs;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
        title: const Text(
          'Name of the Folder/Playlist playing from',
        ),
        // Back Button
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isDark ? KColors.whiteColor : KColors.blackColor,
          ),
        ),
        actions: [
          // More Options Button
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: isDark ? KColors.whiteColor : KColors.blackColor,
            ),
          ),
        ],
      ),
      // Body
      body: Container(
        color: isDark ? KColors.blackColor : KColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Album Art
            Expanded(
              child: Hero(
                tag: 'albumArt',
                child: Align(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isDark
                              ? KColors.offBlackColor
                              : KColors.offBlackColor,
                        ),
                        child: Icon(
                          Icons.music_note,
                          size: 100,
                          color:
                              isDark ? KColors.accentColor : KColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Song Title and Artist
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Song Title",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 20,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.dark
                                        ? KColors.whiteColor
                                        : KColors.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              ("• Artist •"),
                              softWrap: true,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Duration Slider
                  // DurationSlider(
                  //   height: 4,
                  //   activeColor: isDark ? accentColor : blackColor,
                  //   thumbRadius: 6,
                  //   overlayRadius: 20,
                  //   inactiveColor: greyColor,
                  // ),
                  // // Audio Controls
                  // const AudioControlls(playing: true),
                  // // More Controls
                  // MoreControlls(
                  //   bottomSheetCallback: () {
                  //     showModalBottomSheet(
                  //       isScrollControlled: true,
                  //       context: context,
                  //       useSafeArea: true,
                  //       enableDrag: true,
                  //       builder: (context) => const QueueView(),
                  //     );
                  //   },
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

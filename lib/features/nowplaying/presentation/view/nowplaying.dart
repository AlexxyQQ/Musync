import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/state/music_query_state.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/library/presentation/widgets/song_listview.dart'
    as slv;
import 'package:musync/features/nowplaying/presentation/state/now_playing_state.dart';
import 'package:musync/features/nowplaying/presentation/view/queue_view.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
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
  void onMenuItemSelected(String option) {
    // Implement functionality for each option
    switch (option) {
      case 'Delete':
        // Call function for Option 1
        _handleOption1();
        break;
      case 'Info':
        // Call function for Option 2
        _handleOption2();
        break;
      case 'Clear Queue':
        // Call function for Option 3
        _handleOption3();
        break;
    }
  }

  // Function to handle Option 1
  void _handleOption1() {
    setState(() {});
  }

  // Function to handle Option 2
  void _handleOption2() {
    // Show bottom sheet with song info
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.album,
                  size: 16,
                ),
                title: Text(
                  'Album',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text(
                  widget.songList[widget.index].album!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 16,
                ),
                title: Text(
                  'Artist',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text(
                  widget.songList[widget.index].artist!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.music_note,
                  size: 16,
                ),
                title:
                    Text('Genre', style: Theme.of(context).textTheme.bodySmall),
                subtitle: Text(
                  widget.songList[widget.index].genre ?? 'Unknown',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.music_note,
                  size: 16,
                ),
                title: Text(
                  'Duration',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text(
                  "${Duration(milliseconds: widget.songList[widget.index].duration!).toString().split('.').first.split(':')[1]}:${Duration(milliseconds: widget.songList[widget.index].duration!).toString().split('.').first.split(':')[2]}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to handle Option 3
  void _handleOption3() async {
    await BlocProvider.of<NowPlayingViewModel>(context).clearQueue();
    widget.songList.clear();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                onMenuItemSelected: onMenuItemSelected,
              )
            : NowPlayingTablet(
                isDark: isDark,
                isTablet: isTablet,
                isPortrait: isPortrait,
                songs: widget.songList,
                index: widget.index,
                onMenuItemSelected: onMenuItemSelected,
              )
        : isPortrait
            ? NowPlayingPhone(
                isDark: isDark,
                isTablet: isTablet,
                isPortrait: isPortrait,
                songs: widget.songList,
                index: widget.index,
                onMenuItemSelected: onMenuItemSelected,
              )
            : NowPlayingTablet(
                isDark: isDark,
                isTablet: isTablet,
                isPortrait: isPortrait,
                songs: widget.songList,
                index: widget.index,
                onMenuItemSelected: onMenuItemSelected,
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
    required this.onMenuItemSelected,
  });

  final bool isDark;
  final bool isTablet;
  final bool isPortrait;
  final List<SongEntity> songs;
  final int index;
  final Function(String)? onMenuItemSelected;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingViewModel, NowPlayingState>(
      builder: (context, state) {
        return Scaffold(
          // AppBar
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
            centerTitle: true,
            title: Text(
              state.currentSong.data
                  .split('/')[state.currentSong.data.split('/').length - 2],
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleMedium,
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
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.more_vert,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  onSelected: onMenuItemSelected,
                  icon: const Icon(
                    Icons.more_vert_rounded,
                  ),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'Info',
                        child: Row(
                          children: [
                            Icon(Icons.info_rounded),
                            Text('Info'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_rounded),
                            Text('Delete'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Clear Queue',
                        child: Row(
                          children: [
                            Icon(Icons.clear_all_rounded),
                            Text('Clear Queue'),
                          ],
                        ),
                      ),
                    ];
                  },
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
                            child: state.currentSong.albumArtUrl == null ||
                                    state.currentSong.albumArtUrl == ''
                                ? QueryArtworkWidget(
                                    artworkBorder: BorderRadius.circular(20),
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
                                    borderRadius: BorderRadius.circular(20),
                                    data: state.queue,
                                    index: state.currentIndex,
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
                            state.currentSong.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          BlocBuilder<MusicQueryViewModel, MusicQueryState>(
                            builder: (context, musicQueryState) {
                              return InkWell(
                                onTap: () {
                                  // if there is the artist in the artist list then go to the artist page
                                  (musicQueryState.everything['artists']!
                                          .containsKey(
                                              state.currentSong.artist))
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                slv.SongListView(
                                              songs: musicQueryState
                                                      .everything['artists']![
                                                  state.currentSong.artist]!,
                                            ),
                                          ),
                                        )
                                      : null;
                                },
                                child: Text(
                                  ("• ${state.currentSong.artist} •"),
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: KColors.greyColor),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Duration Slider
                DurationSlider(
                  height: 4,
                  activeColor:
                      isDark ? KColors.accentColor : KColors.blackColor,
                  thumbRadius: 6,
                  overlayRadius: 20,
                  inactiveColor: KColors.greyColor,
                  audioPlayer: state.audioPlayer,
                ),
                // Audio Controls
                const AudioControlls(),
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
      },
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
    required this.onMenuItemSelected,
  });

  final bool isDark;
  final bool isTablet;
  final bool isPortrait;
  final List<SongEntity> songs;
  final int index;
  final Function(String)? onMenuItemSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingViewModel, NowPlayingState>(
      builder: (context, state) {
        return Scaffold(
          // AppBar
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
            title: Text(
              state.currentSong.data
                  .split('/')[state.currentSong.data.split('/').length - 2],
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleMedium,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  onSelected: onMenuItemSelected,
                  icon: const Icon(
                    Icons.more_vert_rounded,
                  ),
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'Info',
                        child: Row(
                          children: [
                            Icon(Icons.info_rounded),
                            Text('Info'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_rounded),
                            Text('Delete'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Clear Queue',
                        child: Row(
                          children: [
                            Icon(Icons.clear_all_rounded),
                            Text('Clear Queue'),
                          ],
                        ),
                      ),
                    ];
                  },
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
                            // Add Album Art Here
                            child: state.currentSong.albumArtUrl == null ||
                                    state.currentSong.albumArtUrl == ''
                                ? QueryArtworkWidget(
                                    artworkBorder: BorderRadius.circular(20),
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
                                    borderRadius: BorderRadius.circular(20),
                                    data: songs,
                                    index: index,
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
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  state.currentSong.title,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                BlocBuilder<MusicQueryViewModel,
                                    MusicQueryState>(
                                  builder: (context, musicQueryState) {
                                    return InkWell(
                                      onTap: () {
                                        // if there is the artist in the artist list then go to the artist page
                                        (musicQueryState.everything['artists']!
                                                .containsKey(
                                                    state.currentSong.artist))
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      slv.SongListView(
                                                    songs: musicQueryState
                                                                .everything[
                                                            'artists']![
                                                        state.currentSong
                                                            .artist]!,
                                                  ),
                                                ),
                                              )
                                            : null;
                                      },
                                      child: Text(
                                        ("• ${state.currentSong.artist} •"),
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: KColors.greyColor),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      DurationSlider(
                        height: 4,
                        activeColor:
                            isDark ? KColors.accentColor : KColors.blackColor,
                        thumbRadius: 6,
                        overlayRadius: 20,
                        inactiveColor: KColors.greyColor,
                        audioPlayer: state.audioPlayer,
                      ),
                      // Audio Controls
                      const AudioControlls(),
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
              ],
            ),
          ),
        );
      },
    );
  }
}

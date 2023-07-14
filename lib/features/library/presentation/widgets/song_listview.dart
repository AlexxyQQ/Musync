import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/nowplaying2/presentation/state/now_playing_state.dart';
import 'package:musync/features/nowplaying2/presentation/view_model/now_playing_view_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongListView extends StatelessWidget {
  const SongListView({Key? key, required this.songs}) : super(key: key);

  final List<SongEntity> songs;

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final mqSize = MediaQuery.of(context).size;
    final List<SongEntity> songModels = songs;
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      body: Scrollbar(
        controller: scrollController,
        radius: const Radius.circular(10),
        thickness: 10,
        interactive: true,
        child: CustomScrollView(
          controller: scrollController,
          primary: false, // set primary to false
          slivers: <Widget>[
            // Moving AppBar
            AppBar(
              songs: songModels,
              backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
              mqSize: mqSize,
              isDark: isDark,
            ),
            // More options
            SecondAppBar(
              songs: songModels,
              mqSize: mqSize,
              isDark: isDark,
            ),
            // Display the list of songs
            ListofSongs(
              songs: songModels,
              isDark: isDark,
            )
          ],
        ),
      ),
    );
  }
}

class ListofSongs extends StatefulWidget {
  const ListofSongs({
    Key? key,
    required this.isDark,
    required this.songs,
  }) : super(key: key);

  final bool isDark;
  final List<SongEntity> songs;

  @override
  State<ListofSongs> createState() => _ListofSongsState();
}

class _ListofSongsState extends State<ListofSongs> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final Color songNameColor =
        widget.isDark ? KColors.whiteColor : KColors.blackColor;
    final Color songArtistColor =
        widget.isDark ? KColors.offWhiteColor : KColors.offBlackColor;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final ms = widget.songs[index].duration!;
          Duration duration = Duration(milliseconds: ms);
          int minutes = duration.inMinutes;
          int seconds = duration.inSeconds.remainder(60);

          return InkWell(
            onTap: () async {
              final nav = Navigator.of(context);
              await BlocProvider.of<NowPlayingViewModel>(context).playAll(
                songs: widget.songs,
                index: index,
              );
              nav.pushNamed(
                AppRoutes.nowPlaying,
                arguments: {
                  "songs": widget.songs,
                  "index": index,
                },
              );
            },
            child: Stack(
              children: [
                show ? const PlaylistList() : const SizedBox(),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  height: 60,
                  width: screenWidth,
                  color: KColors.transparentColor,
                  child: Row(
                    children: [
                      // Song Image
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: widget.songs[index].albumArtUrl == null ||
                                widget.songs[index].albumArtUrl == ''
                            ? QueryArtworkWidget(
                                id: widget.songs[index].id,
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
                                data: widget.songs,
                                index: index,
                              ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Song Name
                          SizedBox(
                            width: screenWidth * 0.7,
                            child: Text(
                              widget.songs[index].title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: songNameColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),
                          // Song Artist
                          RichText(
                            text: TextSpan(
                              text:
                                  '${widget.songs[index].artist} • ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: songArtistColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        childCount: widget.songs.length,
      ),
    );
  }
}

class SecondAppBar extends StatelessWidget {
  const SecondAppBar({
    super.key,
    required this.mqSize,
    required this.isDark,
    required this.songs,
  });

  final Size mqSize;
  final bool isDark;
  final List<SongEntity> songs;

  @override
  Widget build(BuildContext context) {
    // find total duration of all songs in the list in hours
    final totalDuration =
        songs.fold<int>(0, (sum, song) => sum + song.duration!);
    final hours = Duration(milliseconds: totalDuration).inHours;
    final minutes =
        Duration(milliseconds: totalDuration).inMinutes.remainder(60);

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        height: 60,
        width: mqSize.width,
        color: KColors.transparentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Text of Total duration of the songs in the folder/playlist
            const Icon(
              Icons.hourglass_full_rounded,
            ),
            Text(
              '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} H',
              // style: TextStyle(
              //   color: isDark ? whiteColor : blackColor,
              //   fontSize: 16,
              //   fontWeight: FontWeight.w600,
              // ),
            ),
            const SizedBox(
              width: 10,
            ),
            // Creator of Playlist or (Path of folder)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 180),
              child: const SizedBox(
                width: 150,
                child: Text(
                  ' • Mobile',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  // style: TextStyle(
                  //   color: isDark ? whiteColor : blackColor,
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
              ),
            ),

            const Spacer(),

            const SizedBox(width: 20),
            // Play all songs
            BlocBuilder<NowPlayingViewModel, NowPlayingState>(
              builder: (context, state) {
                return Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: KColors.accentColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(
                      state.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                      // color: isDark ? whiteColor : blackColor,
                    ),
                    onPressed: () async {
                      if (state.isPlaying) {
                        await context.read<NowPlayingViewModel>().pause();
                      } else {
                        await context.read<NowPlayingViewModel>().play();
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
    required this.backgroundColor,
    required this.mqSize,
    required this.isDark,
    required this.songs,
  });

  final Color backgroundColor;
  final Size mqSize;
  final List<SongEntity> songs;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    // get random song from the list
    final folderNameList = songs.first.data.split('/');
    final folderName = folderNameList[folderNameList.length - 2];
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: 0,
      title: SizedBox(
        width: mqSize.width * 0.7,
        child: Text(
          folderName,
          maxLines: 1,
          // style: TextStyle(
          //   color: isDark ? whiteColor : blackColor,
          //   fontSize: 20,
          //   fontWeight: FontWeight.w600,
          // ),
        ),
      ),
      centerTitle: true,
      // Back button
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          // color: isDark ? whiteColor : blackColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        // Number of songs in the folder/playlist
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            '${songs.length} Songs',
            // style: TextStyle(
            //   color: isDark ? whiteColor : blackColor,
            //   fontSize: 16,
            //   fontWeight: FontWeight.w600,
            // ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.sort_rounded,
            // color: isDark ? whiteColor : blackColor,
          ),
          onPressed: () {
            // TODO: Sort the songs
          },
        )
      ],
    );
  }
}

class PlaylistList extends StatefulWidget {
  const PlaylistList({super.key});

  @override
  State<PlaylistList> createState() => _PlaylistListState();
}

class _PlaylistListState extends State<PlaylistList> {
  late List<PlaylistEntity> playLists = [];

  Future<void> fetchData() async {
    // playLists = await GetIt.instance<MusicQueryUseCase>().getAllPlaylist();
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, controller) => SizedBox(
        height: 500,
        width: double.infinity,
        child: ListView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            if (playLists.isNotEmpty) {
              return ListTile(
                title: Text(playLists[index].playlist),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

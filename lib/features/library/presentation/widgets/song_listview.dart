
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/features/home/domain/entity/playlist_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/nowplaying/presentation/state/now_playing_state.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongListView extends StatefulWidget {
  const SongListView({Key? key, required this.songs}) : super(key: key);

  final List<SongEntity> songs;

  @override
  State<SongListView> createState() => _SongListViewState();
}

class _SongListViewState extends State<SongListView> {
  void onMenuItemSelected(String option) {
    // Implement functionality for each option
    switch (option) {
      case 'A-Z':
        // Call function for Option 1
        _handleOption1();
        break;
      case 'Z-A':
        // Call function for Option 2
        _handleOption2();
        break;
      case 'Date':
        // Call function for Option 3
        _handleOption3();
        break;
      case 'Duration':
        // Call function for Option 4
        _handleOption4();
        break;
    }
  }

  // Function to handle Option 1
  void _handleOption1() {
    widget.songs.sort((a, b) => a.title.compareTo(b.title));
    setState(() {});
  }

  // Function to handle Option 2
  void _handleOption2() {
    widget.songs.sort((a, b) => b.title.compareTo(a.title));
    setState(() {});
  }

  // Function to handle Option 3
  void _handleOption3() {
    widget.songs.sort((a, b) => a.dateAdded!.compareTo(b.dateAdded!));
    setState(() {});
  }

  // Function to handle Option 4
  void _handleOption4() {
    widget.songs.sort((a, b) => a.duration!.compareTo(b.duration!));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final mqSize = MediaQuery.of(context).size;
    final List<SongEntity> songModels = widget.songs;
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
            KAppBar(
              songs: songModels,
              backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
              mqSize: mqSize,
              isDark: isDark,
              onMenuItemSelected: onMenuItemSelected,
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
            ),
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
                AppRoutes.nowPlayingRoute,
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
                          Row(
                            children: [
                              // if from web show web icon
                              if (widget.songs[index].serverUrl != '' &&
                                  widget.songs[index].serverUrl != null)
                                const Icon(
                                  Icons.cloud,
                                  size: 20,
                                  color: KColors.accentColor,
                                ),
                              const SizedBox(width: 5),
                              if (widget.songs[index].isPublic != null &&
                                  widget.songs[index].isPublic!)
                                const Icon(
                                  FontAwesomeIcons.globe,
                                  size: 20,
                                  color: KColors.accentColor,
                                ),
                              const SizedBox(width: 5),
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
            // Total duration of the songs in the folder/playlist
            Text(
              '$hours hr $minutes min',
              style: TextStyle(
                color: isDark ? KColors.whiteColor : KColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
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

            // Play all songs
            BlocBuilder<NowPlayingViewModel, NowPlayingState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: KColors.accentColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          kShowSnackBar(
                            'Songs are being Uploaded',
                            context: context,
                          );
                          await BlocProvider.of<MusicQueryViewModel>(context)
                              .addListOfSongs(songs: songs);
                        },
                        onLongPress: () async {
                          final RenderBox overlay = Overlay.of(context)
                              .context
                              .findRenderObject() as RenderBox;
                          final buttonPosition =
                              (context.findRenderObject() as RenderBox)
                                  .localToGlobal(Offset.zero);
                          final buttonSize =
                              (context.findRenderObject() as RenderBox).size;
                          const menuWidth =
                              150.0; // Customize the menu width as needed

                          double dx = buttonPosition.dx +
                              buttonSize.width +
                              10.0; // Adjust the horizontal position as needed
                          double dy = buttonPosition.dy +
                              buttonSize.height +
                              10.0; // Adjust the vertical position as needed

                          String? selectedOption = await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              dx,
                              dy,
                              overlay.size.width - dx - menuWidth,
                              overlay.size.height - dy,
                            ),
                            items: <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'Public',
                                child: Text('Public Upload'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'Private',
                                child: Text('Private Upload'),
                              ),
                            ],
                          );

                          // Check the selected option and run the corresponding function
                          if (selectedOption == 'Public') {
                            // ignore: use_build_context_synchronously
                            kShowSnackBar(
                              'Songs are being Uploaded',
                              context: context,
                            );
                            // ignore: use_build_context_synchronously
                            await BlocProvider.of<MusicQueryViewModel>(context)
                                .addListOfSongs(songs: songs, isPublic: true);
                          } else if (selectedOption == 'Private') {
                            // ignore: use_build_context_synchronously
                            kShowSnackBar(
                              'Songs are being Uploaded',
                              context: context,
                            );
                            // ignore: use_build_context_synchronously
                            await BlocProvider.of<MusicQueryViewModel>(context)
                                .addListOfSongs(songs: songs);
                          }
                        },
                        child: const Icon(
                          Icons.sync_rounded,
                          // color: isDark ? whiteColor : blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: KColors.accentColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: Icon(
                          state.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow_rounded,
                          // color: isDark ? whiteColor : blackColor,
                        ),
                        onPressed: () async {
                          final nav = Navigator.of(context);
                          await BlocProvider.of<NowPlayingViewModel>(context)
                              .playAll(
                            songs: songs,
                            index: 0,
                          );
                          nav.pushNamed(
                            AppRoutes.nowPlayingRoute,
                            arguments: {
                              "songs": songs,
                              "index": 0,
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class KAppBar extends StatelessWidget {
  const KAppBar({
    super.key,
    required this.backgroundColor,
    required this.mqSize,
    required this.isDark,
    required this.songs,
    required this.onMenuItemSelected,
  });

  final Color backgroundColor;
  final Size mqSize;
  final List<SongEntity> songs;
  final bool isDark;
  final Function(String)? onMenuItemSelected;

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
                  value: 'A-Z',
                  child: Text('A-Z'),
                ),
                const PopupMenuItem<String>(
                  value: 'Z-A',
                  child: Text('Z-A'),
                ),
                const PopupMenuItem<String>(
                  value: 'Date',
                  child: Text('Date'),
                ),
                const PopupMenuItem<String>(
                  value: 'Duration',
                  child: Text('Duration'),
                ),
              ];
            },
          ),
        ),
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

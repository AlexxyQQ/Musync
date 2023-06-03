import 'package:flutter/material.dart';
import 'package:musync/constants/constants.dart';
import 'package:musync/features/home/presentation/components/music/album_art.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongListView extends StatelessWidget {
  const SongListView({Key? key, required this.songs}) : super(key: key);

  //! Change this to SongModel
  final List songs;

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final mqSize = MediaQuery.of(context).size;
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
              songs: songs.map((e) => SongModel(e)).toList(),
              backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
              mqSize: mqSize,
              isDark: isDark,
            ),
            // More options
            SecondAppBar(
              songs: songs.map((e) => SongModel(e)).toList(),
              mqSize: mqSize,
              isDark: isDark,
            ),
            // Display the list of songs
            ListofSongs(
              songs: songs.map((e) => SongModel(e)).toList(),
              isDark: isDark,
            )
          ],
        ),
      ),
    );
  }
}

class ListofSongs extends StatelessWidget {
  const ListofSongs({
    super.key,
    required this.isDark,
    required this.songs,
  });

  final bool isDark;
  final List<SongModel> songs;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final ms = songs[index].duration!;
          Duration duration = Duration(milliseconds: ms);
          int minutes = duration.inMinutes;
          int seconds = duration.inSeconds.remainder(60);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            height: 60,
            width: MediaQuery.of(context).size.width,
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
                  child: ArtWorkImage(
                    id: songs[index].id,
                    filename: songs[index].displayNameWOExt,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Song Name
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        songs[index].title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color:
                              isDark ? KColors.whiteColor : KColors.blackColor,
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
                            '${songs[index].artist} • ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: isDark
                              ? KColors.offWhiteColor
                              : KColors.offBlackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        childCount: songs.length,
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
  final List<SongModel> songs;

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
              child: SizedBox(
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
            // Shuffle all songs
            IconButton(
              icon: Icon(
                Icons.shuffle_rounded,
                // color: isDark ? whiteColor : blackColor,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 20),
            // Play all songs
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: KColors.accentColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.play_arrow_rounded,
                  // color: isDark ? whiteColor : blackColor,
                ),
                onPressed: () {},
              ),
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
  final List<SongModel> songs;
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
        icon: Icon(
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
          icon: Icon(
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/library/presentation/widgets/song_listview.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.data, required this.query})
      : super(key: key);

  final List<SongEntity> data;
  final String query;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void _onSongTap(BuildContext context, int index) {
    final nav = Navigator.of(context);
    BlocProvider.of<NowPlayingViewModel>(context).playAll(
      songs: widget.data,
      index: index,
    );
    nav.pushNamed(
      AppRoutes.nowPlayingRoute,
      arguments: {
        "songs": widget.data,
        "index": index,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final songNameColor = isDark ? KColors.whiteColor : KColors.blackColor;
    final songArtistColor =
        isDark ? KColors.offWhiteColor : KColors.offBlackColor;

    if (widget.data.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'No Data Found',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                "Search Results for:",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                widget.query,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: KColors.greyColor,
                    ),
              ),
            ],
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
        ),
        body: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            final ms = widget.data[index].duration!;
            final duration = Duration(milliseconds: ms);
            final minutes = duration.inMinutes;
            final seconds = duration.inSeconds.remainder(60);

            return InkWell(
              onTap: () => _onSongTap(context, index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                child: ListTile(
                  leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: widget.data[index].albumArtUrl == null ||
                            widget.data[index].albumArtUrl == ''
                        ? QueryArtworkWidget(
                            id: widget.data[index].id,
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
                            data: widget.data,
                            index: index,
                          ),
                  ),
                  title: SizedBox(
                    width: mqSize.width * 0.7,
                    child: Text(
                      widget.data[index].title,
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
                      if (widget.data[index].serverUrl != '' &&
                          widget.data[index].serverUrl != null)
                        const Icon(
                          Icons.cloud,
                          size: 20,
                          color: KColors.accentColor,
                        ),
                      const SizedBox(width: 5),
                      RichText(
                        text: TextSpan(
                          text:
                              '${widget.data[index].artist} • ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
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
      );
    }
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard({
    super.key,
    required this.item,
    required this.mqSize,
    required this.folderName,
    required this.isDark,
    required this.numSongs,
    required this.isCircular,
    this.isArtist = false,
  });

  final dynamic item;
  final Size mqSize;
  final String folderName;
  final bool isDark;
  final int numSongs;
  final bool isCircular;
  final bool isArtist;

  @override
  Widget build(BuildContext context) {
    int randomInt = Random().nextInt(item["songs"].length);
    return InkWell(
      onTap: () {
        // * Navigate to the selected destination
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongListView(
              songs: item["songs"],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        height: 85,
        width: mqSize.width,
        color: KColors.transparentColor,
        child: Row(
          children: [
            isCircular
                ? Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: item["songs"][randomInt].albumArtUrl == null ||
                            item["songs"][randomInt].albumArtUrl == ""
                        ? QueryArtworkWidget(
                            id: item["songs"][randomInt].id,
                            nullArtworkWidget: const Icon(
                              Icons.music_note_rounded,
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
                            index: randomInt,
                            data: item["songs"],
                          ),
                  )
                : SizedBox(
                    height: 80,
                    width: 80,
                    child: item["songs"][randomInt].albumArtUrl == null ||
                            item["songs"][randomInt].albumArtUrl == ""
                        ? QueryArtworkWidget(
                            id: item["songs"][randomInt].id,
                            nullArtworkWidget: const Icon(
                              Icons.music_note_rounded,
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
                            index: randomInt,
                            data: item["songs"],
                          ),
                  ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Name
                SizedBox(
                  width: mqSize.width - 150,
                  child: Text(
                    folderName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 5),
                // Type (Folder or Playlist)
                SizedBox(
                  width: mqSize.width - 150,
                  child: Row(
                    children: [
                      // switch case for type with icon
                      Icon(
                        item['type'] == 'Folder'
                            ? Icons.folder
                            : item['type'] == 'Playlist'
                                ? Icons.playlist_play
                                : item['type'] == 'Album'
                                    ? Icons.album
                                    : Icons.person,
                      ),

                      Expanded(
                        child: Text(
                          isCircular && !isArtist
                              ? ' • ${item["artist"]} • $numSongs Songs'
                              : ' • $numSongs Songs',
                          style: Theme.of(context).textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

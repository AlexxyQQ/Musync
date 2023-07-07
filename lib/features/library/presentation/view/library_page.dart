import 'dart:math';

import 'package:flutter/material.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/loading_screen.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/features/library/presentation/widgets/library_appbar.dart';
import 'package:musync/features/library/presentation/widgets/song_listview.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  changeSort(String newSortBy) {
    setState(() {
      sortBy = newSortBy;
    });
  }

  String sortBy = "All";

  _sort(List<dynamic> items, String sortBy, data) {
    //* Sort the folders
    if (sortBy == 'Folders') {
      data['folders'].forEach((key, value) {
        items.add({
          "type": "Folder",
          "name": key,
          "numSongs": value.length,
          "songs": value
        });
      });
    }
    //* Sort the albums
    else if (sortBy == 'Albums') {
      data['albums'].forEach((key, value) {
        items.add({
          "type": "Album",
          "name": value[0].artist,
          "artist": value[0].artist,
          "numSongs": value.length,
          "songs": value
        });
      });
    }
    //* Sort the artists
    else if (sortBy == 'Artists') {
      data['artists'].forEach((key, value) {
        items.add({
          "type": "Artist",
          "name": key,
          "numSongs": value.length,
          "songs": value
        });
      });
    } else {
      //* Add the folders to the list
      data['folders'].forEach((key, value) {
        items.add({
          "type": "Folder",
          "name": key,
          "numSongs": value.length,
          "songs": value
        });
      });
      //* Add the albums to the list
      data['albums'].forEach((key, value) {
        items.add({
          "type": "Album",
          "name": value[0].album,
          "artist": value[0].artist,
          "numSongs": value.length,
          "songs": value
        });
      });
      //* Add the artists to the list
      data['artists'].forEach((key, value) {
        items.add({
          "type": "Artist",
          "name": key,
          "numSongs": value.length,
          "songs": value
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = ScrollController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: LibraryAppBar(
        isDark: isDark,
        mqSize: mqSize,
        changeSort: changeSort,
      ),
      body: FutureBuilder(
        future: Future(() => widget.data),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            List<dynamic> items = [];
            _sort(items, sortBy, snapshot.data);
            return Scrollbar(
              controller: controller,
              radius: const Radius.circular(10),
              thickness: 10,
              interactive: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  controller: controller,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    if (item['type'] == 'Folder') {
                      final folderName =
                          item["name"].toString().split('/').last;
                      final numSongs = item["numSongs"];
                      return ListViewCard(
                        item: item,
                        mqSize: mqSize,
                        folderName: folderName,
                        isDark: isDark,
                        numSongs: numSongs,
                        isCircular: false,
                      );
                    } else if (item['type'] == 'Artist') {
                      final artistName = item["name"];
                      final numSongs = item["numSongs"];
                      return ListViewCard(
                        item: item,
                        mqSize: mqSize,
                        folderName: artistName,
                        isDark: isDark,
                        numSongs: numSongs,
                        isCircular: true,
                        isArtist: true,
                      );
                    } else {
                      final albumName = item["name"];
                      final numSongs = item["numSongs"];
                      return ListViewCard(
                        item: item,
                        mqSize: mqSize,
                        folderName: albumName,
                        isDark: isDark,
                        numSongs: numSongs,
                        isCircular: true,
                      );
                    }
                  },
                ),
              ),
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
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

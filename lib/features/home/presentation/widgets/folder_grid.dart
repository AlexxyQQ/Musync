import 'package:flutter/material.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/shimmers.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/library/presentation/widgets/song_listview.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeFolderSectionNormal extends StatelessWidget {
  const HomeFolderSectionNormal({
    super.key,
    required this.isDark,
    required this.mqSize,
    required this.isTablet,
    required this.isPortrait,
    required this.isLoading,
    required this.folders,
  });
  final bool isDark;
  final Size mqSize;
  final bool isTablet;
  final bool isPortrait;
  final bool isLoading;
  final Map<String, List<dynamic>> folders;

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, List<dynamic>>> shuffledFolders =
        folders.entries.toList()..shuffle();

    return Column(
      children: [
        // Folders Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Folders',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              // Arrow Button
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 25,
                ),
                color: isDark ? Colors.white : Colors.black,
                onPressed: () {
                  // TODO: Navigate to Folders Page
                },
              ),
            ],
          ),
        ),
        // 2x4 Grid of Folders
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400, minHeight: 150),
            child: isLoading
                ? const HomeFoldersShimmerEffect()
                : GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.6,
                    shrinkWrap: true,
                    children: List.generate(
                      shuffledFolders.length > 6
                          ? 6
                          : shuffledFolders
                              .length, // Show a maximum of 6 folders
                      (index) {
                        final folderEntry = shuffledFolders[index];
                        final folderKey = folderEntry.key;
                        final folderValue = folderEntry.value;
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SongListView(
                                  songs: folderValue as List<SongEntity>,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? KColors.offBlackColorTwo
                                  : KColors.offWhiteColorThree,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Folder Cover
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: mqSize.width * 0.15,
                                  height: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: folderValue[0].albumArtUrl == null ||
                                            folderValue[0].albumArtUrl == ''
                                        ? QueryArtworkWidget(
                                            artworkBorder:
                                                BorderRadius.circular(10),
                                            id: folderValue[0]
                                                .id, // Get the first song in the folder
                                            type: ArtworkType.AUDIO,

                                            nullArtworkWidget: const Icon(
                                              Icons.music_note_rounded,
                                              color: KColors.accentColor,
                                            ),

                                            errorBuilder: (p0, p1, p2) {
                                              return const Icon(
                                                Icons.music_note_rounded,
                                                color: KColors.accentColor,
                                              );
                                            },
                                          )
                                        : QueryArtworkFromApi(
                                            index: 0,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            data: folderValue,
                                          ),
                                  ),
                                ),
                                // Folder Name
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: mqSize.width * 0.2,
                                    child: Text(
                                      folderKey.toString().split('/').last,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GlobalConstants.textStyle(
                                        color: KColors.whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class HomeFolderSectionTablet extends StatelessWidget {
  const HomeFolderSectionTablet({
    super.key,
    required this.isDark,
    required this.mqSize,
    required this.isTablet,
    required this.isPortrait,
    required this.isLoading,
    required this.folders,
  });
  final bool isDark;
  final Size mqSize;
  final bool isTablet;
  final bool isPortrait;
  final bool isLoading;
  final Map<String, List<dynamic>> folders;

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, List<dynamic>>> shuffledFolders =
        folders.entries.toList()..shuffle();
    return Column(
      children: [
        // Folders Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Folders',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              // Arrow Button
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 25,
                ),
                color: isDark ? KColors.whiteColor : KColors.blackColor,
                onPressed: () {
                  // TODO Navigate to Folders Page
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  shuffledFolders.length > 6 ? 6 : shuffledFolders.length,
              itemBuilder: (context, index) {
                final folderEntry = shuffledFolders[index];
                final folderKey = folderEntry.key;
                final folderValue = folderEntry.value;
                return InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongListView(
                          songs: folderValue as List<SongEntity>,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 400,
                    height: 50,
                    margin: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color:
                          isDark // if song is playing from the folder, change color to accentColor
                              ? KColors.offWhiteColorThree
                              : KColors.offBlackColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Folder Cover
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: mqSize.width * 0.15,
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: folderValue[0].albumArtUrl == null ||
                                    folderValue[0].albumArtUrl == ''
                                ? QueryArtworkWidget(
                                    artworkBorder: BorderRadius.circular(10),
                                    id: folderValue[0]
                                        .id, // Get the first song in the folder
                                    type: ArtworkType.AUDIO,

                                    nullArtworkWidget: const Icon(
                                      Icons.music_note_rounded,
                                      color: KColors.accentColor,
                                    ),

                                    errorBuilder: (p0, p1, p2) {
                                      return const Icon(
                                        Icons.music_note_rounded,
                                        color: KColors.accentColor,
                                      );
                                    },
                                  )
                                : QueryArtworkFromApi(
                                    index: 0,
                                    borderRadius: BorderRadius.circular(10),
                                    data: folderValue,
                                  ),
                          ),
                        ),
                        // Folder Name
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            folderKey.toString().split('/').last,
                            maxLines: 1,
                            style: GlobalConstants.textStyle(
                              color: KColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

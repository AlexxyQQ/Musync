import 'package:musync/src/common/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:musync/src/music_library/presentation/components/album_art.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';

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
  final isTablet;
  final isPortrait;
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
                style: textStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
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
            constraints:
                BoxConstraints(maxHeight: mqSize.height * 0.3, minHeight: 100),
            child: isLoading
                ? HomeFoldersShimmerEffect()
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
                        return Container(
                          margin: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: isDark ? offWhiteColorThree : offBlackColor,
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
                                child: ArtWorkImage(
                                  id: folderValue[0][
                                      '_id'], // Get the first song in the folder
                                  filename: folderValue[0]
                                      ['_display_name_wo_ext'],
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
                                    style: textStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
  });

  final bool isDark;
  final Size mqSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Folders Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Folders',
                style: textStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
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
                  // TODO Navigate to Folders Page
                },
              ),
            ],
          ),
        ),
        // 2x4 Grid of Folders
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                width: 400,
                height: 50,
                margin: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color:
                      isDark // if song is playing from the folder, change color to accentColor
                          ? offWhiteColorThree
                          : offBlackColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Folder Cover
                    Container(
                      decoration: BoxDecoration(
                        color: todoColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: 100,
                    ),
                    // Folder Name
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Folder Name',
                        style: textStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

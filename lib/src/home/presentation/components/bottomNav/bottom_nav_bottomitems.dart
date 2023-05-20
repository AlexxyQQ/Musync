import 'package:flutter/material.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';


class BottomItems extends StatelessWidget {
  const BottomItems({
    Key? key,
    required this.isDark,
    required this.selectedIndex,
    required this.onIndexChanged,
    required this.showFolder,
  }) : super(key: key);

  final bool isDark;
  final int selectedIndex;
  final Function(int) onIndexChanged;
  final bool showFolder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: blackColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Home
          IconButton(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color: transparentColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.home_rounded),
            ),
            color: whiteColor,
            onPressed: () => onIndexChanged(0),
            isSelected: selectedIndex == 0,
            selectedIcon: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                  decoration: BoxDecoration(
                    color: offWhiteColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.home_rounded,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Home',
                  style: textStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Search
          IconButton(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color: transparentColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.search_rounded,
              ),
            ),
            color: whiteColor,
            onPressed: () => onIndexChanged(1),
            isSelected: selectedIndex == 1,
            selectedIcon: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                  decoration: BoxDecoration(
                    color: offWhiteColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.search_rounded,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Search',
                  style: textStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Library
          IconButton(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color: transparentColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.my_library_music_rounded),
            ),
            color: whiteColor,
            onPressed: () => onIndexChanged(2),
            isSelected: selectedIndex == 2,
            selectedIcon: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                  decoration: BoxDecoration(
                    color: offWhiteColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.my_library_music_rounded,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Library',
                  style: textStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Folder
          if (showFolder)
            IconButton(
              icon: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                decoration: BoxDecoration(
                  color: transparentColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.folder_rounded),
              ),
              color: whiteColor,
              onPressed: () => onIndexChanged(3),
              isSelected: selectedIndex == 3,
              selectedIcon: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                    decoration: BoxDecoration(
                      color: offWhiteColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.folder_rounded,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Folder',
                    style: textStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

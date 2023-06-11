import 'package:flutter/material.dart';
import 'package:musync/config/constants/constants.dart';

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
      color: KColors.blackColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Home
          _iconButton(
            text: "Home",
            icon: Icons.home_rounded,
            onPressed: () => onIndexChanged(0),
            isSelected: selectedIndex == 0,
          ),

          // Search
          _iconButton(
            text: "Search",
            icon: Icons.search_rounded,
            onPressed: () => onIndexChanged(1),
            isSelected: selectedIndex == 1,
          ),

          // Library
          _iconButton(
            text: "Library",
            icon: Icons.my_library_music_rounded,
            onPressed: () => onIndexChanged(2),
            isSelected: selectedIndex == 2,
          ),
          // Folder
          if (showFolder)
            _iconButton(
              text: "Folder",
              icon: Icons.folder_rounded,
              onPressed: () => onIndexChanged(3),
              isSelected: selectedIndex == 3,
            ),
        ],
      ),
    );
  }

  IconButton _iconButton({
    required String text,
    required IconData icon,
    required Function() onPressed,
    required bool isSelected,
  }) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
        decoration: BoxDecoration(
          color: KColors.transparentColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(icon),
      ),
      color: KColors.whiteColor,
      onPressed: onPressed,
      isSelected: isSelected,
      selectedIcon: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
            decoration: BoxDecoration(
              color: KColors.offWhiteColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              color: KColors.blackColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: GlobalConstants.textStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}


// IconButton(
//             icon: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
//               decoration: BoxDecoration(
//                 color: KColors.transparentColor,
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: const Icon(Icons.my_library_music_rounded),
//             ),
//             color: KColors.whiteColor,
//             onPressed: () => onIndexChanged(2),
//             isSelected: selectedIndex == 2,
//             selectedIcon: Column(
//               children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: KColors.offWhiteColor,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: const Icon(
//                     Icons.my_library_music_rounded,
//                     color: KColors.blackColor,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Library',
//                   style: GlobalConstants.textStyle(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
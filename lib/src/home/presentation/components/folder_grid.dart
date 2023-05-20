import 'package:flutter/material.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';

class HomeFolderSectionNormal extends StatelessWidget {
  const HomeFolderSectionNormal({
    super.key,
    required this.isDark,
    required this.mqSize,
    required this.isTablet,
    required this.isPortrait,
  });

  final bool isDark;
  final Size mqSize;
  final isTablet;
  final isPortrait;

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
            height: isTablet ? 520 : 215,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.6,
              children: List.generate(
                6,
                (index) => Container(
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
                        width: mqSize.width * 0.15,
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

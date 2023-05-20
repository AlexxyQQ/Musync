import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musync/src/home/presentation/components/folder_grid.dart';
import 'package:musync/src/home/presentation/components/horizontal_cards.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final mqSize = MediaQuery.of(context).size;
    bool isTablet = mqSize.width >= tabletSize.width;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: isDark ? blackColor : whiteColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Folders Section
            isTablet
                ? isPortrait
                    ? HomeFolderSectionNormal(
                        isDark: isDark,
                        mqSize: mqSize,
                        isTablet: isTablet,
                        isPortrait: isPortrait)
                    : HomeFolderSectionTablet(isDark: isDark, mqSize: mqSize)
                : HomeFolderSectionNormal(
                    isDark: isDark,
                    mqSize: mqSize,
                    isTablet: isTablet,
                    isPortrait: isPortrait),
            // Albums Section
            HomeOtherSection(
              isDark: isDark,
              cardRoundness: 20,
              sectionTitle: 'Albums',
              mqSize: mqSize,
              isCircular: false,
            ),
            // Artists Section
            HomeOtherSection(
              isDark: isDark,
              cardRoundness: 500,
              sectionTitle: 'Artists',
              cardHeight: 215,
              cardWidth: 180,
              mqSize: mqSize,
              isCircular: true,
            ),
          ],
        ),
      ),
    );
  }
}

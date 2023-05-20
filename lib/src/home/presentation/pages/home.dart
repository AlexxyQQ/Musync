import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musync/src/home/presentation/components/folder_grid.dart';
import 'package:musync/src/home/presentation/components/horizontal_cards.dart';
import 'package:musync/src/music_library/data/providers/song_provider.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/constants.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Map<String, List<dynamic>> folders = {};
  Map<String, List<dynamic>> albums = {};
  Map<String, List<dynamic>> artists = {};
  bool isLoading = true;

  void checkNumbers() async {
    final data = await ref.read(songProvider).getEverythingMusic();
    folders = data['folders'];
    albums = data['albums'];
    artists = data['artists'];
    isLoading = false;
    setState(() {}); // Trigger a rebuild after retrieving the folders
  }

  @override
  void initState() {
    checkNumbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        isPortrait: isPortrait,
                        folders: folders,
                        isLoading: isLoading,
                      )
                    : HomeFolderSectionTablet(isDark: isDark, mqSize: mqSize)
                : HomeFolderSectionNormal(
                    isDark: isDark,
                    mqSize: mqSize,
                    isTablet: isTablet,
                    folders: folders,
                    isLoading: isLoading,
                    isPortrait: isPortrait),
            // Albums Section
            HomeOtherSection(
              isDark: isDark,
              cardRoundness: 20,
              sectionTitle: 'Albums',
              mqSize: mqSize,
              isCircular: false,
              othersData: albums,
              isLoading: isLoading,
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
              othersData: artists,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}

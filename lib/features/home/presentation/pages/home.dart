import 'package:flutter/material.dart';
import 'package:musync/constants/constants.dart';
import 'package:musync/features/home/presentation/components/folder_grid.dart';
import 'package:musync/features/home/presentation/components/horizontal_cards.dart';
import 'package:musync/features/home/repositories/music_repositories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, List<dynamic>> folders = {};
  Map<String, List<dynamic>> albums = {};
  Map<String, List<dynamic>> artists = {};
  bool isLoading = true;

  void checkNumbers() async {
    await MusicRepository().permission();
    var data = await MusicRepository().getEverything();
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
    bool isTablet = mqSize.width >= GlobalConstants.tabletSize.width;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
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
                    isPortrait: isPortrait,
                  ),
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

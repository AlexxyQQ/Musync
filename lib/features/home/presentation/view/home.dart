import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/domain/use_case/music_query_use_case.dart';
import 'package:musync/features/home/presentation/widgets/folder_grid.dart';
import 'package:musync/features/home/presentation/widgets/horizontal_cards.dart';

class HomePageOG extends StatefulWidget {
  const HomePageOG({Key? key}) : super(key: key);

  @override
  State<HomePageOG> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageOG> {
  Map<String, List<SongEntity>> folders = {};
  Map<String, List<SongEntity>> albums = {};
  Map<String, List<SongEntity>> artists = {};
  bool isLoading = true;

  var musicRepo = GetIt.instance<MusicQueryUseCase>();

  Future<void> fetchData() async {
    var musicRepo = GetIt.instance<MusicQueryUseCase>();
    await musicRepo.permission();
    var data = await musicRepo.getEverything();
    folders = data['folders']!;
    albums = data['albums']!;
    artists = data['artists']!;
    if (mounted) {
      // Check if the widget is still mounted before calling setState()
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
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

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.folders,
    required this.albums,
    required this.artists,
    this.isLoading = true,
  }) : super(key: key);

  final Map<String, List<dynamic>> folders;
  final Map<String, List<dynamic>> albums;
  final Map<String, List<dynamic>> artists;

  final bool isLoading;

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

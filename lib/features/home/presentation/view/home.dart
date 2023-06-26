import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/home/presentation/widgets/folder_grid.dart';
import 'package:musync/features/home/presentation/widgets/horizontal_cards.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.folders,
    required this.albums,
    required this.artists,
    this.isLoading = true,
  }) : super(key: key);

  final Map<String, List<SongEntity>> folders;
  final Map<String, List<SongEntity>> albums;
  final Map<String, List<SongEntity>> artists;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final mqSize = MediaQuery.of(context).size;
    bool isTablet = mqSize.width >= GlobalConstants.tabletSize.width;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () async {
          var musicQueryCubit = BlocProvider.of<MusicQueryCubit>(context);
          var token = await GetIt.instance
              .get<HiveQueries>()
              .getValue(boxName: 'users', key: 'token', defaultValue: '');
          musicQueryCubit.getAllSongs(token: token);
          musicQueryCubit.getEverything();
        },
        child: SingleChildScrollView(
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
      ),
    );
  }
}

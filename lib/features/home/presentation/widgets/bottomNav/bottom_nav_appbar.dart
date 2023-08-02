import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/features/home/presentation/state/music_query_state.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/home/presentation/widgets/search_screen.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({
    super.key,
    required this.isDark,
    required this.mqSize,
  });

  final bool isDark;
  final Size mqSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      toolbarHeight: 70,
      elevation: 0,
      centerTitle: true,
      leadingWidth: mqSize.width,
      leading: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: mqSize.width * 0.8,
              height: 48,
              decoration: BoxDecoration(
                color: isDark
                    ? KColors.offBlackColorTwo
                    : KColors.offWhiteColorThree,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  // Drawer Button
                  IconButton(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: isDark ? KColors.whiteColor : KColors.blackColor,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                  // Search Bar
                  BlocBuilder<MusicQueryViewModel, MusicQueryState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: mqSize.width * 0.6,
                        child: TextField(
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            hintText: 'Search Music....',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: KColors.greyColor,
                                ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            fillColor: isDark
                                ? KColors.offBlackColorTwo
                                : KColors.offWhiteColorThree,
                            contentPadding: const EdgeInsets.only(left: 10),
                          ),
                          onTap: () async {
                            await context
                                .read<MusicQueryViewModel>()
                                .toggleOnSearch();
                          },
                          onSubmitted: (value) {
                            // from the list of songs, filter the songs that match the query
                            context
                                .read<MusicQueryViewModel>()
                                .filterSongSearch(
                                  query: value.toLowerCase().trim(), //apple
                                );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(
                                  data: state.filteredSongs,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

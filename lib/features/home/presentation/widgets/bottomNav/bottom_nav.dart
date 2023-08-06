import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/common/loading_screen.dart';
import 'package:musync/features/browse/presentation/view/browse_view.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/state/music_query_state.dart';
import 'package:musync/features/home/presentation/view/home.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_appbar.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_bottomitems.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_bottomsheet.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_drawer.dart';
import 'package:musync/features/home/presentation/widgets/home_view_shimmer.dart';
import 'package:musync/features/home/presentation/widgets/music/music_not_found.dart';
import 'package:musync/features/library/presentation/view/library_page.dart';
import 'package:musync/features/nowplaying/presentation/state/now_playing_state.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PageController _pageController;
  late int selectedIndex = 0;
  bool sync = false;
  var pages = [
    const HomePageShimmer(),
    const LoadingScreen(),
    const LoadingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Get selectedIndex from the router
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        try {
          pages = (ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>)['pages'] as List<Widget>;
        } catch (e) {
          log(e.toString());
        }
        try {
          selectedIndex = (ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>)['selectedIndex'] as int;
          _pageController = PageController(initialPage: selectedIndex);
        } catch (e) {
          log(e.toString());
        }
      }
    });

    var musicQueryCubit = BlocProvider.of<MusicQueryViewModel>(context);
    musicQueryCubit.getEverything();
    musicQueryCubit.getAllPublicSongs();
  }

  void syncTrue() {
    setState(() {
      sync = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: selectedIndex);

    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size mqSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: KAppBar(isDark: isDark, mqSize: mqSize),
      drawer: KDrawer(
        isDark: isDark,
        syncTrue: syncTrue,
      ),
      body: Stack(
        children: [
          BlocBuilder<MusicQueryViewModel, MusicQueryState>(
            builder: (context, state) {
              if (state.isLoading) {
                return PageView.builder(
                  itemCount: pages.length,
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                );
              }
              if (state.error != null) {
                pages = [
                  const HomePageShimmer(),
                  const LoadingScreen(),
                  const LoadingScreen(),
                ];
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  kShowSnackBar(state.error!, context: context);
                });
                return PageView.builder(
                  itemCount: pages.length,
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                );
              } else if (state.everything.isNotEmpty) {
                final Map<String, Map<String, List<SongEntity>>> data =
                    state.everything;

                if (state.onSearch) {
                  pages = [
                    HomePage(
                      folders: data['folders']!,
                      albums: data['albums']!,
                      artists: data['artists']!,
                      isLoading: state.isLoading,
                    ),
                    const BrowseView(),
                    LibraryPage(
                      data: data,
                    ),
                  ];
                }

                pages = [
                  HomePage(
                    folders: data['folders']!,
                    albums: data['albums']!,
                    artists: data['artists']!,
                    isLoading: state.isLoading,
                  ),
                  const BrowseView(),
                  LibraryPage(
                    data: data,
                  ),
                ];
                return PageView.builder(
                  itemCount: pages.length,
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                );
              } else {
                pages = [
                  const MusicNotFound(),
                  const MusicNotFound(),
                  const MusicNotFound(),
                ];
                return PageView.builder(
                  itemCount: pages.length,
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: mqSize.width,
              height: 120,
              child: BlocBuilder<NowPlayingViewModel, NowPlayingState>(
                builder: (context, state) {
                  return (state.isPlaying || state.isPaused)
                      ? const MiniPlayer()
                      : const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomItems(
        showFolder: false,
        isDark: isDark,
        selectedIndex: selectedIndex,
        onIndexChanged: (index) async {
          setState(() {
            selectedIndex = index;
            if (index == 2) {
              try {
                // pages[2] = LibraryPage(
                //   data: data,
                // );
              } catch (e) {
                debugPrint(e.toString());
              }
            }
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }
}

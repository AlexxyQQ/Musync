import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/common/loading_screen.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/state/music_query_state.dart';
import 'package:musync/features/home/presentation/view/home.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_appbar.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_bottomitems.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_drawer.dart';
import 'package:musync/features/home/presentation/widgets/home_view_shimmer.dart';
import 'package:musync/features/home/presentation/widgets/music/music_not_found.dart';
import 'package:musync/features/library/presentation/view/library_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PageController _pageController;
  late int selectedIndex = 0;
  bool sync = false;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    var musicQueryCubit = BlocProvider.of<MusicQueryViewModel>(context);
    musicQueryCubit.getEverything();
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
      body: BlocBuilder<MusicQueryViewModel, MusicQueryState>(
        builder: (context, state) {
          if (pages.isNotEmpty) {
            return PageView.builder(
              itemCount: pages.length,
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return pages[index];
              },
            );
          } else if (state.isLoading) {
            return const HomePageShimmer();
          } else if (state.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              kShowSnackBar(state.error!, context: context);
            });
            return const LoadingScreen();
          } else if (state.everything.isNotEmpty) {
            final Map<String, Map<String, List<SongEntity>>> data =
                state.everything;

            pages = [
              HomePage(
                folders: data['folders']!,
                albums: data['albums']!,
                artists: data['artists']!,
                isLoading: state.isLoading,
              ),
              const LoadingScreen(),
              LibraryPage(data: data)
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
            return const MusicNotFound();
          }
        },
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
                // pages[2] = LibraryPage(data: data);
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

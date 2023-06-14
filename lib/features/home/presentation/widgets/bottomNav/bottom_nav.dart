// // ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/common/loading_screen.dart';
import 'package:musync/features/home/domain/use_case/music_query_use_case.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_appbar.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_bottomitems.dart';
import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_drawer.dart';
import 'package:musync/features/home/presentation/view/home.dart';
import 'package:musync/features/library/presentation/view/library_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PageController _pageController;
  late int selectedIndex = 0;
  late Map<String, List<dynamic>> folders = {};
  late Map<String, List<dynamic>> albums = {};
  late Map<String, List<dynamic>> artists = {};
  late Map<String, dynamic> data = {};
  late bool isLoading = true;
  bool sync = false;
  late List<Widget> pages = [
    HomePage(
      folders: folders,
      albums: albums,
      artists: artists,
      isLoading: isLoading,
    ),
    const LoadingScreen(),
    LibraryPage(
      data: data,
    ),
  ];

  void syncTrue() {
    setState(() {
      sync = true;
    });
  }

  Future<void> fetchData() async {
    var musicUseCase = GetIt.instance<MusicQueryUseCase>();
    data = await musicUseCase.getEverything();
    log("this ran");
    dataForHome(data);
    setState(() {
      sync = false;
    });
  }

  void dataForHome(data) {
    folders = data['folders'];
    albums = data['albums'];
    artists = data['artists'];
    if (mounted) {
      // Check if the widget is still mounted before calling setState()
      setState(() {
        isLoading = false;
        pages[0] = HomePage(
          folders: folders,
          albums: albums,
          artists: artists,
          isLoading: isLoading,
        );
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      if ((ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>)['pages'] !=
          null) {
        pages = (ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>)['pages'] as List<Widget>;
      }
      selectedIndex = (ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>)['selectedIndex'] as int;
    }
    fetchData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: selectedIndex);
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size mqSize = MediaQuery.of(context).size;
    if (sync) {
      fetchData();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      // App Bar
      appBar: KAppBar(isDark: isDark, mqSize: mqSize),
      // Drawer
      drawer: KDrawer(
        isDark: isDark,
        syncTrue: syncTrue,
      ),
      drawerEnableOpenDragGesture: true,
      drawerScrimColor: isDark ? Colors.black54 : Colors.white54,
      // Body
      body: Stack(
        children: [
          PageView.builder(
            itemCount: pages.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomItems(
        showFolder: false,
        isDark: isDark,
        selectedIndex: selectedIndex,
        onIndexChanged: (index) async {
          setState(() {
            selectedIndex = index;
            if (index == 2) {
              try {
                pages[2] = LibraryPage(
                  data: data,
                );
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

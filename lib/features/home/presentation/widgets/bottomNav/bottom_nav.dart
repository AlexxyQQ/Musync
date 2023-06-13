// // ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
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

// class BottomNavBarOG extends StatefulWidget {
//   BottomNavBarOG({
//     this.selectedIndex = 0,
//     this.pages = [
//       // HomePage
//       const HomePage(),
//       const Placeholder(),
//       // Library Page
//       const LibraryPage(),
//       // Folder Page
//       // * hidden initially
//       const Placeholder(),
//     ],
//     Key? key,
//   }) : super(key: key);

//   final List<Widget> pages;
//   int selectedIndex; // Mark selectedIndex as final

//   @override
//   State<BottomNavBarOG> createState() => _BottomNavBarState();
// }

// class _BottomNavBarOGState extends State<BottomNavBarOG> {
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _pageController = PageController(initialPage: widget.selectedIndex);
//     bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     Size mqSize = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
//       // App Bar
//       appBar: KAppBar(isDark: isDark, mqSize: mqSize),
//       // Drawer
//       drawer: KDrawer(isDark: isDark),
//       drawerEnableOpenDragGesture: true,
//       drawerScrimColor: isDark ? Colors.black54 : Colors.white54,
//       // Body
//       body: Stack(
//         children: [
//           PageView.builder(
//             itemCount: widget.pages.length,
//             controller: _pageController,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return widget.pages[index];
//             },
//           ),
//           // Mini Player
//           // Positioned(
//           //   bottom: 0,
//           //   left: 0,
//           //   right: 0,
//           //   child: GestureDetector(
//           //     onTap: () {
//           //       Navigator.pushNamed(context, '/nowPlaying');
//           //     },
//           //     child: const MiniPlayer(),
//           //   ),
//           // ),
//         ],
//       ),
//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomItems(
//         showFolder: false,
//         isDark: isDark,
//         selectedIndex: widget.selectedIndex,
//         onIndexChanged: (index) async {
//           setState(() {
//             widget.selectedIndex = index;
//             if (index == 2) {
//               try {
//                 widget.pages[2] = const LibraryPage();
//               } catch (e) {
//                 debugPrint(e.toString());
//               }
//             }
//             _pageController.animateToPage(
//               index,
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeInOut,
//             );
//           });
//         },
//       ),
//     );
//   }
// }

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

  Future<void> fetchData() async {
    var musicRepo = GetIt.instance<MusicQueryUseCase>();
    await musicRepo.permission();
    data = await musicRepo.getEverything();
    dataForHome(data);
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      // App Bar
      appBar: KAppBar(isDark: isDark, mqSize: mqSize),
      // Drawer
      drawer: KDrawer(isDark: isDark),
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

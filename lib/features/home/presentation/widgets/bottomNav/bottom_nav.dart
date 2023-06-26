// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:musync/config/constants/constants.dart';
// import 'package:musync/core/common/loading_screen.dart';
// import 'package:musync/features/home/presentation/state/music_query_state.dart';
// import 'package:musync/features/home/presentation/view/home.dart';
// import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
// import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_appbar.dart';
// import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_bottomitems.dart';
// import 'package:musync/features/home/presentation/widgets/bottomNav/bottom_nav_drawer.dart';
// import 'package:musync/features/home/presentation/widgets/home_view_shimmer.dart';
// import 'package:musync/features/library/presentation/view/library_page.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key? key}) : super(key: key);

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   late PageController _pageController;
//   late int selectedIndex = 0;
//   late Map<String, List<dynamic>> folders = {};
//   late Map<String, List<dynamic>> albums = {};
//   late Map<String, List<dynamic>> artists = {};
//   late Map<String, dynamic> data = {};
//   late bool isLoading = true;
//   bool sync = false;
//   late List<Widget> pages = [
//     HomePageShimmer(),
//     const LoadingScreen(),
//     LibraryPage(
//       data: data,
//     ),
//   ];

//   void syncTrue() {
//     setState(() {
//       sync = true;
//     });
//   }

//   Future<void> fetchData() async {
//     var musicQueryCubit = BlocProvider.of<MusicQueryCubit>(context);
//     musicQueryCubit.getEverything();
//   }

//   void updateState(MusicQueryState state) {
//     if (state.isLoading) {
//       // Show loading screen
//       setState(() {
//         isLoading = true;
//         pages[0] = const LoadingScreen();
//       });
//     } else if (state.error != null) {
//       // Handle error
//       setState(() {
//         isLoading = false;
//         // Display an error widget instead of the home page
//         pages[0] = ErrorWidget(state.error!);
//       });
//     } else {
//       // Update state with fetched data
//       setState(() {
//         folders = state.everything['folders']!;
//         albums = state.everything['albums']!;
//         artists = state.everything['artists']!;
//         isLoading = false;
//         pages[0] = const HomePageShimmer();
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _pageController = PageController(initialPage: selectedIndex);
//     bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     Size mqSize = MediaQuery.of(context).size;

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
//       // App Bar
//       appBar: KAppBar(isDark: isDark, mqSize: mqSize),
//       // Drawer
//       drawer: KDrawer(
//         isDark: isDark,
//         syncTrue: syncTrue,
//       ),
//       drawerEnableOpenDragGesture: true,
//       drawerScrimColor: isDark ? Colors.black54 : Colors.white54,
//       // Body
//       body: BlocBuilder<MusicQueryCubit, MusicQueryState>(
//         builder: (context, state) {
//           return Stack(
//             children: [
//               PageView.builder(
//                 itemCount: pages.length,
//                 controller: _pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return pages[index];
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomItems(
//         showFolder: false,
//         isDark: isDark,
//         selectedIndex: selectedIndex,
//         onIndexChanged: (index) async {
//           setState(() {
//             selectedIndex = index;
//             if (index == 2) {
//               try {
//                 pages[2] = LibraryPage(
//                   data: data,
//                 );
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

  @override
  void initState() {
    super.initState();
    var musicQueryCubit = BlocProvider.of<MusicQueryCubit>(context);
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
      body: BlocBuilder<MusicQueryCubit, MusicQueryState>(
        builder: (context, state) {
          if (state.isLoading) {
            var pages = [
              const HomePageShimmer(),
              const LoadingScreen(),
              const LoadingScreen(),
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
          if (state.error != null) {
            var pages = [
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
            var pages = [
              HomePage(
                folders: data['folders']!,
                albums: data['albums']!,
                artists: data['artists']!,
                isLoading: state.isLoading,
              ),
              const LoadingScreen(),
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
            var pages = [
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

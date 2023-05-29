// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:musync/core/constants.dart';
import 'package:musync/features/home/presentation/components/bottomNav/bottom_nav_appbar.dart';
import 'package:musync/features/home/presentation/components/bottomNav/bottom_nav_bottomitems.dart';
import 'package:musync/features/home/presentation/components/bottomNav/bottom_nav_drawer.dart';
import 'package:musync/features/home/presentation/pages/home.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    this.selectedIndex = 0,
    this.pages = const <Widget>[
      // HomePage
      HomePage(),
      // TODO: IDK Page
      Placeholder(),
      // Library Page
      Placeholder(), //LibraryPage(),
      // Folder Page
      // * hidden initially
      Placeholder(),
    ],
    Key? key,
  }) : super(key: key);

  final List<Widget> pages;
  int selectedIndex; // Mark selectedIndex as final

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: widget.selectedIndex);
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
            itemCount: widget.pages.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return widget.pages[index];
            },
          ),
          // Mini Player
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.pushNamed(context, '/nowPlaying');
          //     },
          //     child: const MiniPlayer(),
          //   ),
          // ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomItems(
        showFolder: false,
        isDark: isDark,
        selectedIndex: widget.selectedIndex,
        onIndexChanged: (index) async {
          setState(() {
            widget.selectedIndex = index;
            if (index == 2) {
              try {
                widget.pages[2] = const Placeholder(); //LibraryPage();
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

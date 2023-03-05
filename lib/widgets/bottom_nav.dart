import 'package:flutter/material.dart';
import 'package:musync/ui/music/pages/library_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with TickerProviderStateMixin {
  int currentIndex = 0;
  final screens = [
    const LibraryPage(),
    const Placeholder(),
    const Placeholder(),
  ];

  late final List<AnimationController> _animationControllers = List.generate(
    3,
    (index) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    ),
  );

  late final List<Animation<double>> _shakeAnimations =
      _animationControllers.map((controller) {
    final shakeTween = Tween<double>(begin: 0, end: 1);
    final shakeAnimation = shakeTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
    return shakeAnimation;
  }).toList();

  late final List<Animation<double>> _iconAnimations =
      _animationControllers.map((controller) {
    final iconTween = Tween<double>(begin: 0, end: 1);
    final iconAnimation = iconTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
    return iconAnimation;
  }).toList();

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 120),
        child: screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          _animationControllers[currentIndex].reverse();
          _animationControllers[index].forward();
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: AnimatedBuilder(
              animation: _shakeAnimations[currentIndex],
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + (_iconAnimations[currentIndex].value * 0.1),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.music_note_outlined,
                    ),
                  ),
                );
              },
            ),
            activeIcon: AnimatedBuilder(
              animation: _iconAnimations[currentIndex],
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -5 * _shakeAnimations[currentIndex].value),
                  child: Transform.scale(
                    scale: 1 + (_iconAnimations[currentIndex].value * 0.05),
                    child: Expanded(
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.music_note_rounded,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: AnimatedBuilder(
              animation: _shakeAnimations[currentIndex],
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + (_iconAnimations[currentIndex].value * 0.1),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.folder_outlined,
                    ),
                  ),
                );
              },
            ),
            activeIcon: AnimatedBuilder(
              animation: _iconAnimations[currentIndex],
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -5 * _shakeAnimations[currentIndex].value),
                  child: Transform.scale(
                    scale: 1 + (_iconAnimations[currentIndex].value * 0.05),
                    child: Expanded(
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.folder_rounded,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            label: "Folders",
          ),
          BottomNavigationBarItem(
            icon: AnimatedBuilder(
              animation: _shakeAnimations[currentIndex],
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + (_iconAnimations[currentIndex].value * 0.1),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.album_outlined,
                    ),
                  ),
                );
              },
            ),
            activeIcon: AnimatedBuilder(
              animation: _iconAnimations[currentIndex],
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -5 * _shakeAnimations[currentIndex].value),
                  child: Transform.scale(
                    scale: 1 + (_iconAnimations[currentIndex].value * 0.05),
                    child: Expanded(
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.album_rounded,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            label: "Albums",
          ),
        ],
      ),
    );
  }
}

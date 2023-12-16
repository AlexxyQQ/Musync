import 'package:flutter/material.dart';
import 'package:musync/config/constants/global_constants.dart';

/// KPageIndicator - A Customizable Page Indicator for Flutter PageView.
///
/// This widget provides a flexible and visually appealing way to indicate the current page
/// position in a PageView. It's highly customizable, allowing for different colors, sizes,
/// and styles for the active and inactive dots.
///
/// Parameters:
///   [controller] - PageController that this page indicator will respond to.
///   [itemCount] - The total number of items (dots) to display, typically matching the number of pages in the PageView.
///   [activeColor] - (Optional) The Color for the active dot. Defaults to AppAccentColor.yellow.
///   [inactiveColor] - (Optional) The Color for the inactive dots. Defaults to AppIconColor.dim.
///   [activeDotHeight] - (Optional) The height of the active dot. Defaults to 10.0.
///   [activeDotWidth] - (Optional) The width of the active dot. Defaults to 20.0.
///   [inactiveDotHeight] - (Optional) The height of the inactive dots. Defaults to 8.0.
///   [inactiveDotWidth] - (Optional) The width of the inactive dots. Defaults to 20.0.
///   [dotSpacing] - (Optional) The spacing between each dot. Defaults to 8.0.
///   [trailing] - (Optional) A flag to determine if active dots should include trailing dots. Defaults to false.
///
/// Example Usage:
/// ```dart
/// KPageIndicator(
///   controller: _pageController,
///   itemCount: 3,
///   activeColor: Colors.red,
///   inactiveColor: Colors.grey,
///   activeDotHeight: 12.0,
///   activeDotWidth: 24.0,
///   inactiveDotHeight: 10.0,
///   inactiveDotWidth: 10.0,
///   dotSpacing: 5.0,
///   trailing: true,
/// )
/// ```
///
/// Note: Ensure the [PageController] used with this indicator is attached to the same PageView
/// for which you want to display the page index. The active dot style can be customized to highlight
/// the current page, and optional trailing active dots can be enabled for a different visual effect.

class KPageIndicator extends StatefulWidget {
  final PageController controller;
  final int itemCount;
  final Color activeColor;
  final Color inactiveColor;
  final double activeDotHeight;
  final double activeDotWidth;
  final double inactiveDotHeight;
  final double inactiveDotWidth;
  final double dotSpacing;
  final bool trailing;

  const KPageIndicator({
    Key? key,
    required this.controller,
    required this.itemCount,
    this.activeColor = AppAccentColor.yellow,
    this.inactiveColor = AppIconColor.dim,
    this.activeDotHeight = 10.0,
    this.activeDotWidth = 20.0,
    this.inactiveDotHeight = 8.0,
    this.inactiveDotWidth = 20.0,
    this.dotSpacing = 8.0,
    this.trailing = false,
  }) : super(key: key);

  @override
  State<KPageIndicator> createState() => _KPageIndicatorState();
}

class _KPageIndicatorState extends State<KPageIndicator> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.controller.initialPage;
    try {
      widget.controller.addListener(_handlePageChange);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handlePageChange);
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {
      _currentIndex = widget.controller.page!.round();
    });
  }

  void _handleDotPressed(int index) {
    widget.controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.itemCount,
          (index) {
            final isActive = widget.trailing
                ? index <= _currentIndex
                : index == _currentIndex;
            return GestureDetector(
              onTap: () => _handleDotPressed(index),
              child: Container(
                width:
                    isActive ? widget.activeDotWidth : widget.inactiveDotWidth,
                height: isActive
                    ? widget.activeDotHeight
                    : widget.inactiveDotHeight,
                margin: EdgeInsets.symmetric(horizontal: widget.dotSpacing / 2),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(100),
                  color: isActive ? widget.activeColor : widget.inactiveColor,
                  border: isActive
                      ? Border.all(color: widget.activeColor, width: 2.0)
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomPageIndicator extends StatefulWidget {
  final PageController controller;
  final int itemCount;
  final Color activeColor;
  final Color inactiveColor;
  final double dotHeight;
  final double dotWidth;
  final double dotSpacing;
  final bool trailing;

  const CustomPageIndicator({
    Key? key,
    required this.controller,
    required this.itemCount,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.dotHeight = 8.0,
    this.dotSpacing = 8.0,
    this.dotWidth = 20.0,
    this.trailing = false,
  }) : super(key: key);

  @override
  State<CustomPageIndicator> createState() => _CustomPageIndicatorState();
}

class _CustomPageIndicatorState extends State<CustomPageIndicator> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.controller.initialPage;
    widget.controller.addListener(_handlePageChange);
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
    widget.controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.itemCount,
        (index) {
          final isActive =
              widget.trailing ? index <= _currentIndex : index == _currentIndex;
          return GestureDetector(
            onTap: () => _handleDotPressed(index),
            child: Container(
              width: widget.dotWidth,
              height: widget.dotHeight,
              margin: EdgeInsets.symmetric(horizontal: widget.dotSpacing / 2),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                // turn it into rounded rectange
                color: isActive ? widget.activeColor : widget.inactiveColor,
                border: isActive
                    ? Border.all(color: widget.activeColor, width: 2.0)
                    : null,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: widget.activeColor.withOpacity(0.5),
                          blurRadius: 4.0,
                          offset: const Offset(0.0, 2.0),
                        ),
                      ]
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}

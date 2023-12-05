import 'package:flutter/material.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/common/custom_widgets/custom_buttom.dart';

class NextAndSkip extends StatelessWidget {
  const NextAndSkip({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Next Button
          KButton(
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 800),
                curve: Curves.linearToEaseOut,
              );
            },
            label: 'Next',
            lightForegroundColor: AppTextColor.dark,
            darkForegroundColor: AppTextColor.light,
            borderRadius: 26,
          ),

          // Skip Button
          KButton(
            onPressed: () async {
              controller.animateToPage(
                3,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            label: 'Skip',
            borderRadius: 26,
            darkBackgroundColor: Colors.transparent,
            lightBackgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

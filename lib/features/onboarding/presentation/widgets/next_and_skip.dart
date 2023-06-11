import 'package:flutter/material.dart';
import 'package:musync/config/constants/constants.dart';

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
          TextButton(
            style: Theme.of(context).textButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).brightness == Brightness.dark
                        ? KColors.accentColor
                        : KColors.blackColor,
                  ),
                ),
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 800),
                curve: Curves.linearToEaseOut,
              );
            },
            child: Text(
              'Next',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                  ),
            ),
          ),
          // Skip Button
          TextButton(
            onPressed: () async {
              controller.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}

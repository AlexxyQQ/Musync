import 'dart:math';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';

class OnBoardPageBuilder extends StatelessWidget {
  final Color color;
  final String lottieUrl;
  final String title;
  final String subtitle;

  const OnBoardPageBuilder({
    super.key,
    this.color = whiteColor,
    this.lottieUrl = '',
    this.title = '',
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      color: color,
      child: Column(
        children: [
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              title,
              style: textStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
                color: isDark ? whiteColor : blackColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: isDark ? whiteColor : blackColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.465,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: isDark ? offWhiteColorTwo : offWhiteColor,
              ),
              child: Lottie.asset(
                lottieUrl,
                key: Key("${Random().nextInt(1000)}"),
                animate: true,
                frameRate: FrameRate(60),
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

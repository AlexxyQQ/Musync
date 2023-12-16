import 'dart:math';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';

class OnBoardPageComponent extends StatelessWidget {
  final String lottieUrl;
  final String title;
  final String subtitle;

  const OnBoardPageComponent({
    super.key,
    this.lottieUrl = '',
    this.title = '',
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .h5
                .copyWith(color: AppColors().onBackground),
            textAlign: TextAlign.center,
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
              style: Theme.of(context)
                  .textTheme
                  .lBM
                  .copyWith(color: AppColors().onBackground),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.465,
            decoration: BoxDecoration(
              color: AppColors().surfaceContainerHigh,
              borderRadius: BorderRadius.circular(50),
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
    );
  }
}

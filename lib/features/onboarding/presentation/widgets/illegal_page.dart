import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/constants/global_constants.dart';

class IllegalPageBuilder extends StatelessWidget {
  final String lottieUrl;
  final String title;
  final String subtitle;

  const IllegalPageBuilder({
    super.key,
    this.lottieUrl = '',
    this.title = '',
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 28,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(width: 10.w),
                  Switch(
                    value: true,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
          // Toggle Button

          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.465,
              decoration: BoxDecoration(
                color: AppColors().surfaceContainerHighest,
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
      ),
    );
  }
}

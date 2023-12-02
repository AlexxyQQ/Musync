import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants/constants.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120.h,
        width: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).brightness == Brightness.dark
              ? AppBackgroundColor.light.withOpacity(0.98)
              : AppBackgroundColor.dark.withOpacity(0.98),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppAccentColor.yellow,
              strokeWidth: 6,
              strokeCap: StrokeCap.round,
              semanticsValue: 'Loading...',
              semanticsLabel: 'Loading...',
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

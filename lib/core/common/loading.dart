import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants/constants.dart';

Center loading(Size mediaQuerySize, BuildContext context) {
  return Center(
    child: Container(
      height: 120.h,
      width: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          Text(
            'Loading...',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: KColors.whiteColor,
                ),
          ),
        ],
      ),
    ),
  );
}

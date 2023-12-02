import 'package:flutter/material.dart';
import 'package:musync/config/themes/widget_themes/text_styles.dart';
import 'package:musync/core/utils/text_theme_extension.dart';

import '../../config/constants/constants.dart';

void kShowSnackBar({
  required String message,
  BuildContext? context,
  GlobalKey<ScaffoldState>? scaffoldKey,
  Duration duration = const Duration(milliseconds: 1200),
  Color backgroundColor = AppBackgroundColor.light,
  Color textColor = AppTextColor.dark,
}) {
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        elevation: 2,
        content: Text(
          message,
          style: Theme.of(context).textTheme.f10W3.copyWith(
                color: textColor,
              ),
        ),
        duration: duration,
      ),
    );
  } else {
    ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        elevation: 2,
        content: Text(
          message,
          style: AppTextStyle.f10W3.copyWith(
            color: textColor,
          ),
        ),
        duration: duration,
      ),
    );
  }
}

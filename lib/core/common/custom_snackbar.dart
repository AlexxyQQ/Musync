import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musync/config/constants/constants.dart';

void kShowSnackBar(
  String message, {
  BuildContext? context,
  GlobalKey<ScaffoldState>? scaffoldKey,
}) {
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: KColors.offWhiteColor,
        elevation: 2,
        content: Text(
          message,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: KColors.blackColor,
              ),
        ),
        duration: const Duration(milliseconds: 1200),
      ),
    );
  } else {
    ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: KColors.offWhiteColor,
        elevation: 2,
        content: Text(
          message,
          style: GoogleFonts.openSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15,
            color: KColors.blackColor,
          ),
        ),
        duration: const Duration(milliseconds: 1200),
      ),
    );
  }
}

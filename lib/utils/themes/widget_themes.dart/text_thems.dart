import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musync/constants/constants.dart';

class KTextThemes {
  static TextTheme lightTextTheme() {
    return TextTheme(
      // Use For Body
      displayLarge: GoogleFonts.openSans(
        fontSize: 26,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      displayMedium: GoogleFonts.openSans(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      displaySmall: GoogleFonts.openSans(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),

      // Use for Large Extra-Bold Text
      headlineLarge: GoogleFonts.openSans(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),

      // Use for Large Semi-Bold Text
      titleLarge: GoogleFonts.openSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      titleMedium: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      titleSmall: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),

      // Use for small text
      labelLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      labelMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
      labelSmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.blackColor,
      ),
    );
  }

  static TextTheme darkTextTheme() {
    return TextTheme(
      // Use For Body
      displayLarge: GoogleFonts.openSans(
        fontSize: 26,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      displayMedium: GoogleFonts.openSans(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      displaySmall: GoogleFonts.openSans(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),

      // Use for Large Extra-Bold Text
      headlineLarge: GoogleFonts.openSans(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),

      // Use for Large Semi-Bold Text
      titleLarge: GoogleFonts.openSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      titleMedium: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      titleSmall: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),

      // Use for small text
      labelLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      labelMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
      labelSmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: KColors.whiteColor,
      ),
    );
  }
}

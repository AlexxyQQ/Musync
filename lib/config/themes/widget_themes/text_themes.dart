import 'package:flutter/material.dart';
import 'package:musync/config/constants/constants.dart';

class KTextThemes {
  // Styles for body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppTextColor.dark,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppTextColor.dark,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppTextColor.dark,
  );

  // Styles for headings
  static const TextStyle headingLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.15,
    color: AppTextColor.dark,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    color: AppTextColor.dark,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    color: AppTextColor.dark,
  );

  // Styles for captions
  static const TextStyle captionLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppTextColor.dark,
  );

  static const TextStyle captionMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppTextColor.dark,
  );

  static const TextStyle captionSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppTextColor.dark,
  );

  static TextTheme lightTextTheme() {
    return const TextTheme(
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      headlineLarge: headingLarge,
      headlineMedium: headingMedium,
      headlineSmall: headingSmall,
      labelLarge: captionLarge,
      labelMedium: captionMedium,
      labelSmall: captionSmall,
    ).apply(
      displayColor: AppTextColor.dark,
      bodyColor: AppTextColor.dark,
    );
  }

  static TextTheme darkTextTheme() {
    return lightTextTheme()
        .copyWith(
          bodyLarge: bodyLarge.copyWith(color: AppTextColor.light),
          bodyMedium: bodyMedium.copyWith(color: AppTextColor.light),
          bodySmall: bodySmall.copyWith(color: AppTextColor.light),
          headlineLarge: headingLarge.copyWith(color: AppTextColor.light),
          headlineMedium: headingMedium.copyWith(color: AppTextColor.light),
          headlineSmall: headingSmall.copyWith(color: AppTextColor.light),
          labelLarge: captionLarge.copyWith(color: AppTextColor.light),
          labelMedium: captionMedium.copyWith(color: AppTextColor.light),
          labelSmall: captionSmall.copyWith(color: AppTextColor.light),
        )
        .apply(
          displayColor: AppTextColor.light,
          bodyColor: AppTextColor.light,
        );
  }
}

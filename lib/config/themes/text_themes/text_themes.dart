import 'package:flutter/material.dart';
import 'package:musync/config/constants/colors/app_colors.dart';

class KTextThemes {
  // Styles for body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppLightColor.onBackground,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppLightColor.onBackground,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppLightColor.onBackground,
  );

  // Styles for headings
  static const TextStyle headingLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.15,
    color: AppLightColor.onBackground,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    color: AppLightColor.onBackground,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
    color: AppLightColor.onBackground,
  );

  // Styles for captions
  static const TextStyle captionLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppLightColor.onBackground,
  );

  static const TextStyle captionMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppLightColor.onBackground,
  );

  static const TextStyle captionSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppLightColor.onBackground,
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
      displayColor: AppLightColor.onBackground,
      bodyColor: AppLightColor.onBackground,
    );
  }

  static TextTheme darkTextTheme() {
    return lightTextTheme()
        .copyWith(
          bodyLarge: bodyLarge.copyWith(color: AppDarkColor.onBackground),
          bodyMedium: bodyMedium.copyWith(color: AppDarkColor.onBackground),
          bodySmall: bodySmall.copyWith(color: AppDarkColor.onBackground),
          headlineLarge:
              headingLarge.copyWith(color: AppDarkColor.onBackground),
          headlineMedium:
              headingMedium.copyWith(color: AppDarkColor.onBackground),
          headlineSmall:
              headingSmall.copyWith(color: AppDarkColor.onBackground),
          labelLarge: captionLarge.copyWith(color: AppDarkColor.onBackground),
          labelMedium: captionMedium.copyWith(color: AppDarkColor.onBackground),
          labelSmall: captionSmall.copyWith(color: AppDarkColor.onBackground),
        )
        .apply(
          displayColor: AppDarkColor.onBackground,
          bodyColor: AppDarkColor.onBackground,
        );
  }
}

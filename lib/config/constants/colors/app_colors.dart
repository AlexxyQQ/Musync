import 'package:flutter/scheduler.dart';
import 'package:musync/config/constants/colors/primitive_colors.dart';
import 'package:musync/core/common/exports.dart';

class AppDarkColor {
  static const Color background = PrimitiveColors.grey900;
  static const Color onBackground = PrimitiveColors.grey50;
  static const Color error = PrimitiveColors.error400;
  static const Color onError = PrimitiveColors.error800;
  static const Color errorContainer = PrimitiveColors.error700;
  static const Color onErrorContainer = PrimitiveColors.error300;
  static const Color primary = PrimitiveColors.primary400;
  static const Color onPrimary = PrimitiveColors.primary800;
  static const Color primaryContainer = PrimitiveColors.primary700;
  static const Color onPrimaryContainer = PrimitiveColors.primary300;
  static const Color primaryFixed = PrimitiveColors.primary700;
  static const Color primaryFixedDim = PrimitiveColors.primary600;
  static const Color onPrimaryFixed = PrimitiveColors.primary800;
  static const Color onPrimaryFixedVariant = PrimitiveColors.primary600;
  static const Color secondary = PrimitiveColors.secondary400;
  static const Color onSecondary = PrimitiveColors.secondary800;
  static const Color secondaryContainer = PrimitiveColors.secondary700;
  static const Color onSecondaryContainer = PrimitiveColors.secondary300;
  static const Color secondaryFixed = PrimitiveColors.secondary700;
  static const Color secondaryFixedDim = PrimitiveColors.secondary600;
  static const Color onSecondaryFixed = PrimitiveColors.secondary800;
  static const Color onSecondaryFixedVariant = PrimitiveColors.secondary600;
  static const Color surface = PrimitiveColors.grey900;
  static const Color surfaceDim = PrimitiveColors.grey700;
  static const Color surfaceBright = PrimitiveColors.grey600;
  static const Color surfaceContainerLow = PrimitiveColors.grey600;
  static const Color surfaceContainerLowest = PrimitiveColors.grey700;
  static const Color surfaceContainer = PrimitiveColors.grey500;
  static const Color surfaceContainerHigh = PrimitiveColors.grey400;
  static const Color surfaceContainerHighest = PrimitiveColors.grey300;
  static const Color onSurface = PrimitiveColors.grey100;
  static const Color onSurfaceVariant = PrimitiveColors.grey300;
  static const Color outline = PrimitiveColors.grey400;
  static const Color outlineVariant = PrimitiveColors.grey500;
  static const Color accent = PrimitiveColors.accent400;
  static const Color onAccent = PrimitiveColors.accent800;
  static const Color accentContainer = PrimitiveColors.accent700;
  static const Color onAccentContainer = PrimitiveColors.accent300;
  static const Color accentFixed = PrimitiveColors.accent700;
  static const Color accentFixedDim = PrimitiveColors.accent600;
  static const Color onAccentFixed = PrimitiveColors.accent800;
  static const Color onAccentFixedVariant = PrimitiveColors.accent600;
}

class AppLightColor {
// Accent color aliases
  static const Color accent = PrimitiveColors.accent500;
  static const Color onAccent = PrimitiveColors.accent100;
  static const Color accentContainer = PrimitiveColors.accent300;
  static const Color onAccentContainer = PrimitiveColors.accent800;
  static const Color accentFixed = PrimitiveColors.accent300;
  static const Color accentFixedDim = PrimitiveColors.accent400;
  static const Color onAccentFixed = PrimitiveColors.accent800;
  static const Color onAccentFixedVariant = PrimitiveColors.accent600;
  // Backconst ground color aliases
  static const Color background = PrimitiveColors.grey50;
  static const Color onBackground = PrimitiveColors.grey900;
  // Erroconst r color aliases
  static const Color error = PrimitiveColors.error500;
  static const Color onError = PrimitiveColors.error100;
  static const Color errorContainer = PrimitiveColors.error300;
  static const Color onErrorContainer = PrimitiveColors.error800;
  // Primconst ary color aliases
  static const Color primary = PrimitiveColors.primary500;
  static const Color primaryContainer = PrimitiveColors.primary300;
  static const Color primaryFixed = PrimitiveColors.primary300;
  static const Color primaryFixedDim = PrimitiveColors.primary400;
  static const Color onPrimaryContainer = PrimitiveColors.primary800;
  static const Color onPrimaryFixed = PrimitiveColors.primary800;
  static const Color onPrimary = PrimitiveColors.primary100;
  static const Color onPrimaryFixedVariant = PrimitiveColors.primary600;
  // Secoconst ndary color aliases
  static const Color secondary = PrimitiveColors.secondary500;
  static const Color secondaryContainer = PrimitiveColors.secondary300;
  static const Color secondaryFixed = PrimitiveColors.secondary300;
  static const Color secondaryFixedDim = PrimitiveColors.secondary400;
  static const Color onSecondary = PrimitiveColors.secondary100;
  static const Color onSecondaryContainer = PrimitiveColors.secondary800;
  static const Color onSecondaryFixed = PrimitiveColors.secondary800;
  static const Color onSecondaryFixedVariant = PrimitiveColors.secondary600;
  // Surfconst ace color aliases
  static const Color surface = PrimitiveColors.grey50;
  static const Color surfaceDim = PrimitiveColors.grey100;
  static const Color surfaceBright = PrimitiveColors.grey50;
  static const Color surfaceContainerLow = PrimitiveColors.grey200;
  static const Color surfaceContainerLowest = PrimitiveColors.grey100;
  static const Color surfaceContainer = PrimitiveColors.grey300;
  static const Color surfaceContainerHigh = PrimitiveColors.grey400;
  static const Color surfaceContainerHighest = PrimitiveColors.grey500;
  static const Color onSurface = PrimitiveColors.grey900;
  static const Color onSurfaceVariant = PrimitiveColors.grey800;
  static const Color outline = PrimitiveColors.grey700;
  static const Color outlineVariant = PrimitiveColors.grey600;
}

class AppColors {
  final bool inverseDarkMode;

  AppColors({this.inverseDarkMode = false});
  final _isDarkMode =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;

  var change = false;

  Color get background => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.background
      : AppLightColor.background;

  Color get onBackground => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onBackground
      : AppLightColor.onBackground;

  Color get error => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.error
      : AppLightColor.error;

  Color get onError => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onError
      : AppLightColor.onError;

  Color get errorContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.errorContainer
      : AppLightColor.errorContainer;

  Color get onErrorContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onErrorContainer
      : AppLightColor.onErrorContainer;

  Color get primary => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.primary
      : AppLightColor.primary;

  Color get onPrimary => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onPrimary
      : AppLightColor.onPrimary;

  Color get primaryContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.primaryContainer
      : AppLightColor.primaryContainer;

  Color get onPrimaryContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onPrimaryContainer
      : AppLightColor.onPrimaryContainer;

  Color get primaryFixed => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.primaryFixed
      : AppLightColor.primaryFixed;

  Color get primaryFixedDim => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.primaryFixedDim
      : AppLightColor.primaryFixedDim;

  Color get onPrimaryFixed => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onPrimaryFixed
      : AppLightColor.onPrimaryFixed;

  Color get onPrimaryFixedVariant => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onPrimaryFixedVariant
      : AppLightColor.onPrimaryFixedVariant;

  Color get secondary => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.secondary
      : AppLightColor.secondary;

  Color get onSecondary => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onSecondary
      : AppLightColor.onSecondary;

  Color get secondaryContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.secondaryContainer
      : AppLightColor.secondaryContainer;

  Color get onSecondaryContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onSecondaryContainer
      : AppLightColor.onSecondaryContainer;

  Color get secondaryFixed => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.secondaryFixed
      : AppLightColor.secondaryFixed;

  Color get secondaryFixedDim => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.secondaryFixedDim
      : AppLightColor.secondaryFixedDim;

  Color get onSecondaryFixed => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onSecondaryFixed
      : AppLightColor.onSecondaryFixed;

  Color get onSecondaryFixedVariant => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onSecondaryFixedVariant
      : AppLightColor.onSecondaryFixedVariant;

  Color get surface => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.surface
      : AppLightColor.surface;

  Color get surfaceDim => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.surfaceDim
      : AppLightColor.surfaceDim;

  Color get surfaceBright => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.surfaceBright
      : AppLightColor.surfaceBright;

  Color get surfaceContainerLow => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.surfaceContainerLow
      : AppLightColor.surfaceContainerLow;

  Color get surfaceContainerLowest => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.surfaceContainerLowest
      : AppLightColor.surfaceContainerLowest;

  Color get surfaceContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.surfaceContainer
      : AppLightColor.surfaceContainer;

  Color get surfaceContainerHigh => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.surfaceContainerHigh
      : AppLightColor.surfaceContainerHigh;

  Color get surfaceContainerHighest => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.surfaceContainerHighest
      : AppLightColor.surfaceContainerHighest;

  Color get onSurface => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onSurface
      : AppLightColor.onSurface;

  Color get onSurfaceVariant => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onSurfaceVariant
      : AppLightColor.onSurfaceVariant;

  Color get outline => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.outline
      : AppLightColor.outline;

  Color get outlineVariant => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.outlineVariant
      : AppLightColor.outlineVariant;

  Color get accent => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.accent
      : AppLightColor.accent;

  Color get onAccent => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onAccent
      : AppLightColor.onAccent;

  Color get accentContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.accentContainer
      : AppLightColor.accentContainer;

  Color get onAccentContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onAccentContainer
      : AppLightColor.onAccentContainer;

  Color get accentFixed => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.accentFixed
      : AppLightColor.accentFixed;

  Color get accentFixedDim => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.accentFixedDim
      : AppLightColor.accentFixedDim;

  Color get onAccentFixed => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onAccentFixed
      : AppLightColor.onAccentFixed;

  Color get onAccentFixedVariant => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onAccentFixedVariant
      : AppLightColor.onAccentFixedVariant;
}

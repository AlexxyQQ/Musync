import 'package:flutter/scheduler.dart';
import 'package:musync/config/constants/colors/primitive_colors.dart';
import 'package:musync/core/common/exports.dart';

class AppDarkColor {
  static const Color primary = PrimitiveColors.primary800;
  static const Color onPrimary = PrimitiveColors.primary200;
  static const Color primaryContainer = PrimitiveColors.primary300;
  static const Color onPrimaryContainer = PrimitiveColors.primary900;
  static const Color primaryFixed = PrimitiveColors.primary900;
  static const Color primaryFixedDim = PrimitiveColors.primary800;
  static const Color onPrimaryFixed = PrimitiveColors.primary100;
  static const Color onPrimaryFixedVariant = PrimitiveColors.primary300;

  static const Color secondary = PrimitiveColors.secondary800;
  static const Color onSecondary = PrimitiveColors.secondary200;
  static const Color secondaryContainer = PrimitiveColors.secondary300;
  static const Color onSecondaryContainer = PrimitiveColors.secondary900;
  static const Color secondaryFixed = PrimitiveColors.secondary900;
  static const Color secondaryFixedDim = PrimitiveColors.secondary800;
  static const Color onSecondaryFixed = PrimitiveColors.secondary100;
  static const Color onSecondaryFixedVariant = PrimitiveColors.secondary300;

  static const Color tertiary = PrimitiveColors.tertiary800;
  static const Color onTertiary = PrimitiveColors.tertiary200;
  static const Color tertiaryContainer = PrimitiveColors.tertiary300;
  static const Color onTertiaryContainer = PrimitiveColors.tertiary900;
  static const Color tertiaryFixed = PrimitiveColors.tertiary900;
  static const Color tertiaryFixedDim = PrimitiveColors.tertiary800;
  static const Color onTertiaryFixed = PrimitiveColors.tertiary100;
  static const Color onTertiaryFixedVariant = PrimitiveColors.tertiary300;

  static const Color error = PrimitiveColors.error800;
  static const Color onError = PrimitiveColors.error200;
  static const Color errorContainer = PrimitiveColors.error300;
  static const Color onErrorContainer = PrimitiveColors.error900;
  static const Color errorFixed = PrimitiveColors.error900;
  static const Color errorFixedDim = PrimitiveColors.error800;
  static const Color onErrorFixed = PrimitiveColors.error100;
  static const Color onErrorFixedVariant = PrimitiveColors.error300;

  static const Color surfaceDim = PrimitiveColors.grey200;
  static const Color surface = PrimitiveColors.grey60;
  static const Color surfaceBright = PrimitiveColors.grey240;
  static const Color surfaceContainerLowest = PrimitiveColors.grey40;
  static const Color surfaceContainerLow = PrimitiveColors.grey100;
  static const Color surfaceContainer = PrimitiveColors.grey120;
  static const Color surfaceContainerHigh = PrimitiveColors.grey170;
  static const Color surfaceContainerHighest = PrimitiveColors.grey220;
  static const Color onSurface = PrimitiveColors.grey900;
  static const Color onSurfaceVariant = PrimitiveColors.greyV800;
  static const Color outline = PrimitiveColors.greyV600;
  static const Color outlineVariant = PrimitiveColors.greyV300;
  static const Color inverseSurface = PrimitiveColors.grey900;
  static const Color inverseOnSurface = PrimitiveColors.grey200;
  static const Color inversePrimary = PrimitiveColors.primary400;
  static const Color scrim = PrimitiveColors.grey0;
  static const Color shadow = PrimitiveColors.grey0;
  static const Color background = PrimitiveColors.grey60;
  static const Color onBackground = PrimitiveColors.grey960;
}

class AppLightColor {
  static const Color primary = PrimitiveColors.primary400;
  static const Color onPrimary = PrimitiveColors.primary1000;
  static const Color primaryContainer = PrimitiveColors.primary900;
  static const Color onPrimaryContainer = PrimitiveColors.primary100;
  static const Color primaryFixed = PrimitiveColors.primary900;
  static const Color primaryFixedDim = PrimitiveColors.primary800;
  static const Color onPrimaryFixed = PrimitiveColors.primary100;
  static const Color onPrimaryFixedVariant = PrimitiveColors.primary300;

  static const Color secondary = PrimitiveColors.secondary400;
  static const Color onSecondary = PrimitiveColors.secondary1000;
  static const Color secondaryContainer = PrimitiveColors.secondary900;
  static const Color onSecondaryContainer = PrimitiveColors.secondary100;
  static const Color secondaryFixed = PrimitiveColors.secondary900;
  static const Color secondaryFixedDim = PrimitiveColors.secondary800;
  static const Color onSecondaryFixed = PrimitiveColors.secondary100;
  static const Color onSecondaryFixedVariant = PrimitiveColors.secondary300;

  static const Color tertiary = PrimitiveColors.tertiary400;
  static const Color onTertiary = PrimitiveColors.tertiary1000;
  static const Color tertiaryContainer = PrimitiveColors.tertiary900;
  static const Color onTertiaryContainer = PrimitiveColors.tertiary100;
  static const Color tertiaryFixed = PrimitiveColors.tertiary900;
  static const Color tertiaryFixedDim = PrimitiveColors.tertiary800;
  static const Color onTertiaryFixed = PrimitiveColors.tertiary100;
  static const Color onTertiaryFixedVariant = PrimitiveColors.tertiary300;

  static const Color error = PrimitiveColors.error400;
  static const Color onError = PrimitiveColors.error1000;
  static const Color errorContainer = PrimitiveColors.error900;
  static const Color onErrorContainer = PrimitiveColors.error100;
  static const Color errorFixed = PrimitiveColors.error900;
  static const Color errorFixedDim = PrimitiveColors.error800;
  static const Color onErrorFixed = PrimitiveColors.error100;
  static const Color onErrorFixedVariant = PrimitiveColors.error300;

  static const Color surfaceDim = PrimitiveColors.grey870;
  static const Color surface = PrimitiveColors.grey980;
  static const Color surfaceBright = PrimitiveColors.grey980;
  static const Color surfaceContainerLowest = PrimitiveColors.grey1000;
  static const Color surfaceContainerLow = PrimitiveColors.grey960;
  static const Color surfaceContainer = PrimitiveColors.grey940;
  static const Color surfaceContainerHigh = PrimitiveColors.grey920;
  static const Color surfaceContainerHighest = PrimitiveColors.grey900;
  static const Color onSurface = PrimitiveColors.grey100;
  static const Color onSurfaceVariant = PrimitiveColors.greyV300;

  static const Color outline = PrimitiveColors.greyV500;
  static const Color outlineVariant = PrimitiveColors.greyV800;

  static const Color inverseSurface = PrimitiveColors.grey200;
  static const Color inverseOnSurface = PrimitiveColors.grey950;
  static const Color inversePrimary = PrimitiveColors.primary800;

  static const Color scrim = PrimitiveColors.grey0;
  static const Color shadow = PrimitiveColors.grey0;

  static const Color background = PrimitiveColors.grey960;
  static const Color onBackground = PrimitiveColors.grey60;
}

class AppColors {
  final bool inverseDarkMode;

  AppColors({this.inverseDarkMode = false});
  final _isDarkMode =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;

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

  Color get tertiary => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.tertiary
      : AppLightColor.tertiary;

  Color get onTertiary => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onTertiary
      : AppLightColor.onTertiary;

  Color get tertiaryContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.tertiaryContainer
      : AppLightColor.tertiaryContainer;

  Color get onTertiaryContainer => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onTertiaryContainer
      : AppLightColor.onTertiaryContainer;

  Color get tertiaryFixed => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.tertiaryFixed
      : AppLightColor.tertiaryFixed;

  Color get tertiaryFixedDim => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.tertiaryFixedDim
      : AppLightColor.tertiaryFixedDim;

  Color get onTertiaryFixed => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onTertiaryFixed
      : AppLightColor.onTertiaryFixed;

  Color get onTertiaryFixedVariant => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.onTertiaryFixedVariant
      : AppLightColor.onTertiaryFixedVariant;

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

  Color get inverseSurface => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.inverseSurface
      : AppLightColor.inverseSurface;

  Color get inverseOnSurface => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.inverseOnSurface
      : AppLightColor.inverseOnSurface;

  Color get inversePrimary => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.inversePrimary
      : AppLightColor.inversePrimary;

  Color get scrim => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.scrim
      : AppLightColor.scrim;

  Color get shadow => (_isDarkMode != inverseDarkMode)
      ? AppDarkColor.shadow
      : AppLightColor.shadow;
}

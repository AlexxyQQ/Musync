import 'package:flutter/material.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/constants/global_constants.dart';
import 'package:musync/config/themes/text_themes/all_text_styles.dart';
import 'package:musync/config/themes/text_themes/text_themes.dart';

class AppTheme {
  static appLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      // Font Family
      // Text Theme
      textTheme: KTextThemes.lightTextTheme().apply(
        displayColor: AppLightColor.onBackground,
        bodyColor: AppLightColor.onBackground,
        fontFamily: 'Manrope',
      ),
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppLightColor.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 70,
        iconTheme: IconThemeData(
          color: AppLightColor.onBackground,
        ),
      ),
      // Scaffold Background Color
      scaffoldBackgroundColor: AppLightColor.background,
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppLightColor.onSurface,
          backgroundColor: AppLightColor.surface,
          textStyle: AllTextStyle.f16W8.copyWith(
            color: AppLightColor.onSurface,
          ),
          minimumSize: const Size(100, 30),
          maximumSize: const Size(400, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          animationDuration: const Duration(milliseconds: 150),
        ),
      ),
      // Scrollbar Theme
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(AppLightColor.primary),
        trackColor: MaterialStateProperty.all(AppLightColor.onSurfaceVariant),
        interactive: true,
        thumbVisibility: MaterialStateProperty.all(true),
        radius: const Radius.circular(12),
        trackVisibility: MaterialStateProperty.all(false),
      ),
      // Drawer Theme
      drawerTheme: const DrawerThemeData(
        elevation: 0,
        backgroundColor: AppLightColor.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: AllTextStyle.f16W8.copyWith(
            color: AppLightColor.onSurface,
          ),
          elevation: 5,
          backgroundColor: KColors.transparentColor,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppLightColor.onSurface,
      ),
      primaryIconTheme: const IconThemeData(
        color: AppLightColor.primary,
      ),
    );
  }

  static appDarkTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      // Font Family
      // Text Theme
      textTheme: KTextThemes.darkTextTheme().apply(
        displayColor: AppDarkColor.onBackground,
        bodyColor: AppDarkColor.onBackground,
        fontFamily: 'Manrope',
      ),
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppDarkColor.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 70,
        iconTheme: IconThemeData(
          color: AppDarkColor.onBackground,
        ),
      ),
      // Scaffold Background Color
      scaffoldBackgroundColor: AppDarkColor.background,
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppDarkColor.onSurface,
          backgroundColor: AppDarkColor.surface,
          textStyle: AllTextStyle.f16W8.copyWith(
            color: AppDarkColor.onSurface,
          ),
          minimumSize: const Size(100, 30),
          maximumSize: const Size(400, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          animationDuration: const Duration(milliseconds: 150),
        ),
      ),
      // Scrollbar Theme
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(AppDarkColor.primary),
        trackColor: MaterialStateProperty.all(AppDarkColor.onSurfaceVariant),
        interactive: true,
        thumbVisibility: MaterialStateProperty.all(true),
        radius: const Radius.circular(12),
        trackVisibility: MaterialStateProperty.all(false),
      ),
      // Drawer Theme
      drawerTheme: const DrawerThemeData(
        elevation: 0,
        backgroundColor: AppDarkColor.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: AllTextStyle.f16W8.copyWith(
            color: AppDarkColor.onSurface,
          ),
          elevation: 5,
          backgroundColor: KColors.transparentColor,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppDarkColor.onSurface,
      ),
      primaryIconTheme: const IconThemeData(
        color: AppDarkColor.primary,
      ),
    );
  }
}

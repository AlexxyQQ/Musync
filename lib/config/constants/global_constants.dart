import 'package:flutter/material.dart';

class GlobalConstants {
  static const Size tabletSize = Size(600, 1024);

  static textStyle({
    family = 'Sans',
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color = AppTextColor.light,
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

class KColors {
  static const transparentColor = Colors.transparent;
  static const whiteColor = Color(0xFFFAFAFA);
  static const blackColor = Color(0xFF101010);
  static const offBlackColor = Color(0xFF1E1E1E);
  static const offBlackColorTwo = Color(0xFF383838);
  static const offWhiteColor = Color(0xFFE1E7EC);
  static const offWhiteColorTwo = Color(0xFF696C6E);
  static const offWhiteColorThree = Color.fromARGB(255, 184, 189, 192);
  static const greyColor = Color(0xFF666666);
  static const tertiaryColor = Color(0xFFFFC800);
  static const todoColor = Colors.red;
}

class AppTertiaryColor {
  static const yellow = Color(0xFFFFC800);
  static const green = Color(0xFFA1CD44);
  static const red = Color(0xFFCD5444);
  static const highlights = Color(0xFF407BFF);
}

class AppTextColor {
  static const light = Color(0xFFF3F3F3);
  static const dark = Color(0xFF1F1F1F);
  static const dim = Color(0xFF76808C);
  static const lightDim = Color(0xFFD9D9D9);
}

class AppIconColor {
  static const light = Color(0xFFF3F3F3);
  static const dark = Color(0xFF1F1F1F);
  static const dim = Color(0xFF76808C);
  static const lightDim = Color(0xFFD9D9D9);
}

class AppBackgroundColor {
  static const light = Color(0xFFF3F3F3);
  static const dark = Color(0xFF1A1A1A);
  static const darkDim = Color(0xFFB8B8B8);
  static const lightDim = Color(0xFFE0E0E0);
}

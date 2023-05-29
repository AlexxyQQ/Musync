import 'package:flutter/material.dart';

class GlobalConstants {
  static const Size tabletSize = Size(600, 1024);

  static textStyle({
    family = 'Sans',
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color = KColors.whiteColor,
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
  static const offWhiteColor = Color(0xFFE1E7EC);
  static const offWhiteColorTwo = Color(0xFF696C6E);
  static const offWhiteColorThree = Color.fromARGB(255, 184, 189, 192);
  static const greyColor = Color(0xFF666666);
  static const accentColor = Color(0xFFFFC800);
  static const todoColor = Colors.red;
}

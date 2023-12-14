import 'package:flutter/material.dart';
import 'package:musync/config/themes/text_themes/all_text_styles.dart';

extension AppCustomTextStyle on TextTheme {
  // ==================== HEADINGS ====================
  TextStyle get h1 => AllTextStyle.f36W7.copyWith(
        height: 1.3,
      );
  TextStyle get h2 => AllTextStyle.f32W7.copyWith(
        height: 1.3,
      );
  TextStyle get h3 => AllTextStyle.f28W7.copyWith(
        height: 1.3,
      );
  TextStyle get h4 => AllTextStyle.f24W7.copyWith(
        height: 1.3,
      );
  TextStyle get h5 => AllTextStyle.f18W7.copyWith(
        height: 1.3,
      );
  TextStyle get h6 => AllTextStyle.f16W7.copyWith(
        height: 1.3,
      );

  // ==================== BODY ====================
  // ==================== BODY BOLD ====================
  TextStyle get bBL => AllTextStyle.f16W8;
  TextStyle get bBM => AllTextStyle.f14W8;
  TextStyle get bBS => AllTextStyle.f12W8;
  // ==================== BODY MEDIUM ====================
  TextStyle get mBL => AllTextStyle.f16W5;
  TextStyle get mBM => AllTextStyle.f14W5;
  TextStyle get mBS => AllTextStyle.f12W5;
  // ==================== BODY Light ====================
  TextStyle get lBL => AllTextStyle.f16W3;
  TextStyle get lBM => AllTextStyle.f14W3;
  TextStyle get lBS => AllTextStyle.f12W3;

  // ==================== CAPTIONS ====================
  // ==================== CAPTIONS BOLD ====================
  TextStyle get bC => AllTextStyle.f10W8;
  // ==================== CAPTIONS MEDIUM ====================
  TextStyle get mC => AllTextStyle.f10W5;
  // ==================== CAPTIONS LIGHT ====================
  TextStyle get lC => AllTextStyle.f10W3;
}

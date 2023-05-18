import 'package:flutter/material.dart';
import 'package:musync/src/utils/colors.dart';

textStyle({
  family = 'Sans',
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w400,
  Color? color = whiteColor,
}) {
  return TextStyle(
    fontFamily: family,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

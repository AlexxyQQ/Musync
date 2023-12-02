import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/utils/text_theme_extension.dart';

class KButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? darkBackgroundColor;
  final Color? darkForegroundColor;
  final Color? lightBackgroundColor;
  final Color? lightForegroundColor;
  final double? elevation;
  final Size? fixedSize;
  final Color? darkDisabledForegroundColor;
  final Color? lightDisabledForegroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final IconData? iconData;
  final String? label;
  final double? borderRadius;
  const KButton({
    super.key,
    required this.onPressed,
    this.elevation,
    this.fixedSize,
    this.padding,
    this.darkBackgroundColor,
    this.darkForegroundColor,
    this.lightBackgroundColor,
    this.lightForegroundColor,
    this.darkDisabledForegroundColor,
    this.lightDisabledForegroundColor,
    this.textStyle,
    this.iconData,
    this.label,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12), // User input
        ),
        backgroundColor: isDark
            ? lightBackgroundColor ?? AppBackgroundColor.light
            : darkBackgroundColor ?? AppBackgroundColor.dark,
        foregroundColor: isDark
            ? lightForegroundColor ?? AppBackgroundColor.light
            : darkForegroundColor ?? AppBackgroundColor.dark,
        elevation: 0, // User input
        maximumSize: Size(350.w, 60.h),
        minimumSize: Size(50.w, 40.h),
        fixedSize: fixedSize ?? Size(350.w, 40.h), // User input
        disabledForegroundColor: isDark
            ? lightDisabledForegroundColor ?? AppTextColor.lightDim
            : darkDisabledForegroundColor ?? AppTextColor.dim,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
            ), // User input
        textStyle: textStyle ?? Theme.of(context).textTheme.f16W7,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconData != null ? Icon(iconData) : const SizedBox.shrink(),
          (iconData != null || label != null)
              ? const SizedBox(width: 10)
              : const SizedBox.shrink(),
          label != null ? Text(label!) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

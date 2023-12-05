import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/utils/text_theme_extension.dart';

/// KButton - A Customizable Elevated Button for Flutter Applications.
///
/// This widget provides a versatile and customizable button that can be easily adapted
/// to different UI designs. It supports various customizations including colors, size,
/// elevation, icon, and text styling. This button is designed to cater to both dark and
/// light themes, offering flexibility in UI design.
///
/// Parameters:
///   [onPressed] - A void Function callback that is triggered when the button is pressed.
///   [darkBackgroundColor] - (Optional) The background color for dark theme. Defaults to AppBackgroundColor.dark.
///   [darkForegroundColor] - (Optional) The foreground (text/icon) color for dark theme.
///   [lightBackgroundColor] - (Optional) The background color for light theme. Defaults to AppBackgroundColor.light.
///   [lightForegroundColor] - (Optional) The foreground (text/icon) color for light theme.
///   [elevation] - (Optional) The elevation of the button. Defaults to 0.
///   [fixedSize] - (Optional) The fixed size of the button.
///   [padding] - (Optional) The internal padding of the button.
///   [darkDisabledForegroundColor] - (Optional) The foreground color when the button is disabled in dark theme.
///   [lightDisabledForegroundColor] - (Optional) The foreground color when the button is disabled in light theme.
///   [textStyle] - (Optional) The TextStyle for the button label.
///   [iconData] - (Optional) The icon to be displayed alongside the button label.
///   [label] - (Optional) The text label of the button.
///   [borderRadius] - (Optional) The border radius of the button.
///
/// Example Usage:
/// ```dart
/// KButton(
///   onPressed: () {
///     // Your code here
///   },
///   label: 'Click Me',
///   iconData: Icons.touch_app,
///   darkBackgroundColor: Colors.blue,
///   lightBackgroundColor: Colors.green,
///   borderRadius: 15.0,
/// )
/// ```
///
/// Note: The button adapts its color based on the current theme context (dark or light). If no colors are specified,
/// it defaults to predefined values. You can customize the button's appearance extensively through the provided parameters.

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

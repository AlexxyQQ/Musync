import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';

/// KButton - A Customizable Elevated Button for Flutter Applications.
///
/// This widget provides a versatile and customizable button that can be easily adapted
/// to different UI designs. It supports various customizations including colors, size,
/// elevation, icon, and text styling. This button is designed to cater to both dark and
/// light themes, offering flexibility in UI design.
///
/// Parameters:
///   [onPressed] - A void Function callback that is triggered when the button is pressed.
///   [backgroundColor] - (Optional) The background color for dark theme. Defaults to AppBackgroundColor.dark.
///   [foregroundColor] - (Optional) The foreground (text/icon) color for dark theme.
///   [lightBackgroundColor] - (Optional) The background color for light theme. Defaults to AppBackgroundColor.light.
///   [lightForegroundColor] - (Optional) The foreground (text/icon) color for light theme.
///   [elevation] - (Optional) The elevation of the button. Defaults to 0.
///   [fixedSize] - (Optional) The fixed size of the button.
///   [padding] - (Optional) The internal padding of the button.
///   [disabledForegroundColor] - (Optional) The foreground color when the button is disabled in dark theme.
///   [disabledBackgroundColor] - (Optional) The foreground color when the button is disabled in light theme.
///   [textStyle] - (Optional) The TextStyle for the button label.
///   [iconData] - (Optional) The icon to be displayed alongside the button label.
///   [label] - (Optional) The text label of the button.
///   [borderRadius] - (Optional) The border radius of the button.
///   [svg] - (Optional) The SVG icon to be displayed alongside the button label.
///   [picture] - (Optional) The image to be displayed alongside the button label.
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
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final Size? fixedSize;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final IconData? iconData;
  final String? label;
  final double? borderRadius;
  final String? svg;
  final String? picture;
  const KButton({
    super.key,
    required this.onPressed,
    this.elevation,
    this.fixedSize,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
    this.textStyle,
    this.iconData,
    this.label,
    this.borderRadius,
    this.svg,
    this.picture,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> buildRowChildren() {
      List<Widget> widgets = [];

      // Helper function to add widget and a spacer
      void addWidgetWithSpacer(Widget widget) {
        if (widgets.isNotEmpty) {
          widgets.add(const SizedBox(width: 12)); // Spacer
        }
        widgets.add(widget);
      }

      // Add SVG if not null
      if (svg != null) {
        addWidgetWithSpacer(
          SvgPicture.asset(
            svg!,
            width: 20.w,
            height: 20.h,
            color: foregroundColor ?? AppColors().onSurface,
          ),
        );
      }

      // Add Picture if not null
      if (picture != null) {
        addWidgetWithSpacer(
          Image.asset(
            picture!,
            width: 20.w,
            height: 20.h,
            color: foregroundColor ?? AppColors().onSurface,
          ),
        );
      }

      // Add Icon if not null
      if (iconData != null) {
        addWidgetWithSpacer(Icon(iconData));
      }

      // Add Text if not null
      if (label != null) {
        addWidgetWithSpacer(Text(label!));
      }

      return widgets;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12), // User input
        ),
        backgroundColor: backgroundColor ?? AppColors().surface,
        foregroundColor: foregroundColor ?? AppColors().onSurface,
        elevation: 0, // User input
        maximumSize: Size(350.w, 60.h),
        minimumSize: Size(50.w, 40.h),
        fixedSize: fixedSize ?? Size(350.w, 40.h), // User input
        disabledForegroundColor:
            disabledForegroundColor ?? AppColors().surfaceContainerHigh,
        disabledBackgroundColor:
            disabledBackgroundColor ?? AppColors().surfaceDim,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
            ), // User input
        textStyle: textStyle ?? Theme.of(context).textTheme.bBL,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildRowChildren(),
      ),
    );
  }
}

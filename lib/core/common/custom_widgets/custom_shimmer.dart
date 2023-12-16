import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// KShimmerEffect - A Versatile Shimmer Effect Widget for Flutter.
///
/// This widget creates a shimmer effect, which is commonly used as a placeholder or loading indicator.
/// It is highly customizable, allowing for circular or rectangular shapes, and offers control over
/// various aesthetic aspects such as size, color, and border radius. The shimmer effect adapts to
/// the current theme (dark or light mode) of the application.
///
/// Parameters:
///   [isCircular] - A boolean flag to switch between circular and rectangular shapes. Defaults to false.
///   [height] - (Optional) The height of the shimmer widget. Only applicable for rectangular shape.
///   [width] - (Optional) The width of the shimmer widget. For circular shapes, this represents the diameter.
///   [darkBaseColor] - (Optional) The base color of the shimmer effect in dark mode. Defaults to a dark grey.
///   [lightBaseColor] - (Optional) The base color of the shimmer effect in light mode. Defaults to a light grey.
///   [lightHighlightColor] - (Optional) The highlight color of the shimmer in light mode. Defaults to a very light grey.
///   [darkHighlightColor] - (Optional) The highlight color of the shimmer in dark mode. Defaults to a medium grey.
///   [borderRadius] - (Optional) The border radius for the shimmer widget. Applicable only for rectangular shapes.
///   [darkContainerColor] - (Optional) The background color of the shimmer widget in dark mode.
///   [lightContainerColor] - (Optional) The background color of the shimmer widget in light mode.
///
/// Usage Example:
/// ```dart
/// KShimmerEffect(
///   isCircular: true, // For circular shape
///   width: 100, // Diameter for circular or width for rectangular
///   darkBaseColor: Colors.grey[850], // Dark mode base color
///   lightBaseColor: Colors.grey[200], // Light mode base color
///   lightHighlightColor: Colors.grey[100], // Light mode highlight color
///   darkHighlightColor: Colors.grey[600], // Dark mode highlight color
///   borderRadius: 15, // Border radius for rectangular shape
///   // Other parameters...
/// )
/// ```
///
/// Note: This widget is especially useful for skeleton screens or loading indicators. Its adaptability to different
/// themes and shapes makes it a versatile choice for various UI/UX designs in Flutter applications.

class KShimmerEffect extends StatelessWidget {
  final bool isCircular;
  final double? height;
  final double? width;
  final Color? darkBaseColor;
  final Color? lightBaseColor;
  final Color? lightHighlightColor;
  final Color? darkHighlightColor;
  final double? borderRadius;
  final Color? darkContainerColor;
  final Color? lightContainerColor;

  const KShimmerEffect({
    Key? key,
    this.isCircular = false,
    this.height,
    this.width,
    this.darkBaseColor,
    this.lightBaseColor,
    this.lightHighlightColor,
    this.darkHighlightColor,
    this.borderRadius,
    this.darkContainerColor,
    this.lightContainerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDarkMode
          ? (darkBaseColor ?? Colors.grey[800]!)
          : (lightBaseColor ?? Colors.grey[300]!),
      highlightColor: isDarkMode
          ? (darkHighlightColor ?? Colors.grey[500]!)
          : (lightHighlightColor ?? Colors.grey[100]!),
      child: isCircular
          ? CircleAvatar(
              radius: (width ?? 100) / 2,
              backgroundColor: isDarkMode
                  ? (darkContainerColor ?? Colors.grey[800])
                  : (lightContainerColor ?? Colors.grey[300]),
            )
          : Container(
              margin: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? (darkContainerColor ?? Colors.grey[800])
                    : (lightContainerColor ?? Colors.grey[300]),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              height: height,
              width: width,
            ),
    );
  }
}

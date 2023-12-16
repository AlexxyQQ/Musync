import 'package:flutter/material.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/themes/text_themes/all_text_styles.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';


/// kShowSnackBar - A Utility Function for Displaying SnackBars in Flutter Applications.
///
/// This function provides a convenient and consistent way to show snack bar notifications
/// in Flutter applications. It's designed to be used across different screens and components
/// for displaying brief messages in a snack bar format.
///
/// Parameters:
///   [message] - A String representing the message to be displayed in the snack bar.
///   [context] - (Optional) The BuildContext in which to find the ScaffoldMessenger. If null,
///               scaffoldKey must be provided.
///   [scaffoldKey] - (Optional ) GlobalKey<ScaffoldState> to access the current Scaffold's state.
///                   Required if context is not provided.
///   [duration] - (Optional) The Duration for how long the snack bar should be shown. Defaults to 1200 milliseconds.
///   [backgroundColor] - (Optional) The Color for the snack bar's background. Defaults to AppBackgroundColor.light.
///   [textColor] - (Optional) The Color for the text in the snack bar. Defaults to AppTextColor.dark.
///
/// Usage:
/// To show a snack bar, simply call `kShowSnackBar` with the required message and either a context
/// or a scaffoldKey. Here's an example:
///
/// ```dart
/// kShowSnackBar(
///   message: 'This is a snack bar message!',
///   context: context, // Use this if you have a BuildContext available.
///   // Or use the scaffoldKey if BuildContext is not available.
///   // scaffoldKey: _scaffoldKey,
/// )
/// ```
///
/// Note: Ensure that either a [BuildContext] or a [GlobalKey<ScaffoldState>] is provided to the function.
/// The function will display the snack bar within the closest Scaffold widget in the widget tree.

void kShowSnackBar({
  required String message,
  BuildContext? context,
  bool isError = false,
  GlobalKey<ScaffoldState>? scaffoldKey,
  Duration duration = const Duration(milliseconds: 1200),
  Color backgroundColor = AppLightColor.surfaceContainerLowest,
  Color textColor = AppLightColor.onSurface,
}) {
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            isError ? AppLightColor.errorContainer : backgroundColor,
        elevation: 2,
        content: Text(
          message,
          style: Theme.of(context).textTheme.mBS.copyWith(
                color: textColor,
              ),
        ),
        duration: duration,
      ),
    );
  } else {
    ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            isError ? AppLightColor.errorContainer : backgroundColor,
        elevation: 2,
        content: Text(
          message,
          style: AllTextStyle.f12W5.copyWith(
            color: textColor,
          ),
        ),
        duration: duration,
      ),
    );
  }
}

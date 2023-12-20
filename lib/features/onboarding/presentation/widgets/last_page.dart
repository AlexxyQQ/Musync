import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/route/routes.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';
import 'package:musync/injection/app_injection_container.dart';

import '../../../../core/common/custom_widgets/custom_snackbar.dart';
import '../../../../core/common/hive/hive_service/setting_hive_service.dart';
import '../../../../core/utils/connectivity_check.dart';

class LastPage extends StatelessWidget {
  const LastPage({
    super.key,
    required this.mediaQuerySize,
    required this.changeLoading,
  });
  final Size mediaQuerySize;
  final Function(bool value) changeLoading;

  Future<bool> onTap() async {
    changeLoading(true);
    final settings = await get<SettingsHiveService>().getSettings();
    final isConnected = await ConnectivityCheck.connectivity();
    final isServerUp = await ConnectivityCheck.isServerup(recheck: true);

    if (isConnected && isServerUp) {
      await get<SettingsHiveService>().updateSettings(
        settings.copyWith(
          server: true,
        ),
      );
      changeLoading(false);
      return true;
    } else {
      changeLoading(false);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Terms and Conditions
        Text(
          "By continuing, you’re agreeing to \n Musync Privacy policy and Terms of use.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.lC.copyWith(
                color: AppColors().onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 20),
        // Get Started Offline
        InkWell(
          onTap: () async {
            final navigator = Navigator.of(context);

            navigator.pushNamedAndRemoveUntil(
              AppRoutes.homeRoute,
              (route) => false,
            );
          },
          child: Text(
            'Get Started Offline',
            style: Theme.of(context).textTheme.mBM,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        // Get Started Online
        InkWell(
          onTap: () async {
            final navigator = Navigator.of(context);
            final data = await onTap();
            if (data) {
              navigator.pushNamedAndRemoveUntil(
                AppRoutes.getStartedRoute,
                (route) => false,
              );
            } else {
              // ignore: use_build_context_synchronously
              kShowSnackBar(
                message: "No Internet Connection or server is down.",
                context: context,
                isError: true,
              );
            }
          },
          child: Container(
            height: 67,
            width: mediaQuerySize.width,
            decoration: BoxDecoration(
              color: isDarkMode ? AppDarkColor.primary : AppLightColor.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Get Started Now',
                  style: Theme.of(context)
                      .textTheme
                      .h4
                      .copyWith(color: AppLightColor.onBackground),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

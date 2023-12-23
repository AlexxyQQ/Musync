import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/constants/colors/primitive_colors.dart';
import 'package:musync/config/route/routes.dart';
import 'package:musync/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/injection/app_injection_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../auth/presentation/cubit/authentication_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _zoomAnimationController;
  Animation<double>? _zoomAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    init();
  }

  void _initAnimations() {
    _zoomAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _zoomAnimation =
        Tween<double>(begin: 1.0, end: 1.5).animate(_zoomAnimationController!);

    // Start animation after 1 second
    Future.delayed(const Duration(milliseconds: 1000), () {
      _zoomAnimationController!.forward();
    });
  }

  @override
  void dispose() {
    _zoomAnimationController?.dispose();
    super.dispose();
  }

  init() async {
    final nav = Navigator.of(context);
    final authCubit = BlocProvider.of<AuthenticationCubit>(context);
    await authCubit.initialLogin(context: context);

    final settings = await get<SettingsHiveService>().getSettings();
    _zoomAnimationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (settings.firstTime) {
          nav.pushNamed(AppRoutes.onBoardingRoute);
        } else if ((authCubit.state.loggedUser != null &&
                authCubit.state.loggedUser!.username != null) ||
            settings.goHome) {
          nav.pushNamed(AppRoutes.bottomNavRoute);
        } else {
          nav.pushNamed(AppRoutes.loginRoute);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _zoomAnimationController!,
          builder: (context, child) {
            return Transform.scale(
              scale: _zoomAnimation!.value,
              child: child,
            );
          },
          child: const SplashComponents(),
        ),
      ),
    );
  }
}

class SplashComponents extends StatelessWidget {
  const SplashComponents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blob 1
        Positioned(
          top: 0,
          right: MediaQuery.of(context).size.width / 2.5,
          child: SvgPicture.asset(
            'assets/splash_screen/blob.svg', // Replace with your SVG image path
            height: 80.h,
            width: 60.w,
          ),
        ),
        // Blob 2
        Positioned(
          top: 400.h,
          right: -15,
          child:
              // rotation the svg 90 degree
              Transform.rotate(
            angle: 1.8,
            child: SvgPicture.asset(
              'assets/splash_screen/blob.svg', // Replace with your SVG image path
              height: 60.h,
              width: 35.w,
            ),
          ),
        ),
        // Line 1
        Positioned(
          top: 80.h,
          right: MediaQuery.of(context).size.width / 3.5,
          child: Transform.rotate(
            angle: 4.2,
            child: SvgPicture.asset(
              'assets/splash_screen/line.svg', // Replace with your SVG image path
              height: 130.h,
              width: 130.w,
            ),
          ),
        ),
        // Line 2
        Positioned(
          top: 500.h,
          right: MediaQuery.of(context).size.width / 3.5,
          child: SvgPicture.asset(
            'assets/splash_screen/line.svg', // Replace with your SVG image path
            height: 130.h,
            width: 130.w,
          ),
        ),

        // Elipse 1
        const Positioned(
          top: -20,
          right: -80,
          child: CircleAvatar(
            backgroundColor: PrimitiveColors.primary500,
            radius: 100,
          ),
        ),
        // Elipse 2
        const Positioned(
          top: 180,
          left: -70,
          child: CircleAvatar(
            backgroundColor: PrimitiveColors.primary500,
            radius: 60,
          ),
        ),
        // Elipse 3
        const Positioned(
          bottom: 150,
          left: -60,
          child: CircleAvatar(
            backgroundColor: PrimitiveColors.primary500,
            radius: 90,
          ),
        ),
        // Elipse 4
        const Positioned(
          bottom: -50,
          right: -20,
          child: CircleAvatar(
            backgroundColor: PrimitiveColors.primary500,
            radius: 50,
          ),
        ),

        // Musics
        Positioned(
          top: 250.h,
          left: 40,
          child: SvgPicture.asset(
            'assets/splash_screen/music1.svg', // Replace with your SVG image path
            height: 20.h,
            width: 20.w,
          ),
        ),
        Positioned(
          bottom: -8.h,
          left: 40,
          child: SvgPicture.asset(
            'assets/splash_screen/music1.svg', // Replace with your SVG image path
            height: 20.h,
            width: 20.w,
          ),
        ),
        Positioned(
          top: 50.h,
          left: 100,
          child: SvgPicture.asset(
            'assets/splash_screen/music2.svg', // Replace with your SVG image path
            height: 20.h,
            width: 20.w,
          ),
        ),
        Positioned(
          top: 200.h,
          right: 60,
          child: SvgPicture.asset(
            'assets/splash_screen/music2.svg', // Replace with your SVG image path
            height: 20.h,
            width: 20.w,
          ),
        ),
        Positioned(
          bottom: 150.h,
          right: 40,
          child: SvgPicture.asset(
            'assets/splash_screen/music2.svg', // Replace with your SVG image path
            height: 20.h,
            width: 20.w,
          ),
        ),
        Positioned(
          bottom: 240.h,
          left: 80,
          child: SvgPicture.asset(
            'assets/splash_screen/music2.svg', // Replace with your SVG image path
            height: 20.h,
            width: 20.w,
          ),
        ),

        // Title and subtitle and logo
        Positioned(
          top: 250.h,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/splash_screen/Logo.svg', // Replace with your SVG image path
                height: 80.h,
                width: 80.w,
              ),
              Text(
                'Musync',
                style: Theme.of(context)
                    .textTheme
                    .h1
                    .copyWith(color: AppColors().onBackground),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                ' Your ultimate music companion.',
                style: Theme.of(context)
                    .textTheme
                    .mBL
                    .copyWith(color: AppColors().onBackground),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

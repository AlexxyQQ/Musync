import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/custom_widgets/custom_page_indicator.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';
import 'package:musync/features/onboarding/presentation/widgets/last_page.dart';
import 'package:musync/features/onboarding/presentation/widgets/next_and_skip.dart';
import 'package:musync/features/onboarding/presentation/widgets/page_builder.dart';

import '../../../../core/common/static_loader.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  static PageController controller = PageController();
  bool isLastPage = false;
  bool loading = false;

  void changeLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    List<dynamic> pages = [
      const OnBoardPageComponent(
        lottieUrl: 'assets/lottie/4879-trumpet-music.json',
        title: 'Seamless Music Transition',
        subtitle: 'Switch tunes between devices without missing a beat',
      ),
      const OnBoardPageComponent(
        lottieUrl: 'assets/lottie/animation_lk5n0846.json',
        title: 'Personalized Playlist Creation',
        subtitle: 'Craft and manage your soundtracks with custom playlists.',
      ),
      const OnBoardPageComponent(
        lottieUrl:
            'assets/lottie/139537-boy-avatar-listening-music-animation.json',
        title: 'Social Tunes Sharing',
        subtitle: "Share your favorite hits instantly on social media.",
      ),
      const OnBoardPageComponent(
        lottieUrl:
            'assets/lottie/139537-boy-avatar-listening-music-animation.json',
        title: 'Get started now!!',
        subtitle:
            "Discover new favorites with personalized song recommendations.",
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: mediaQuerySize.width,
          child: Stack(
            children: [
              PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 3;
                  });
                },
                scrollDirection: Axis.horizontal,
                reverse: false,
                physics: const BouncingScrollPhysics(),
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
              // App icon and name and Page Indicator
              Positioned(
                top: 30,
                left: 0,
                right: 0,
                child: IconAndPageIndicator(
                  controller: controller,
                ),
              ),
              // Get Started Offline and Terms and Conditions
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: isLastPage
                    // Get Started Offline and Terms and Conditions
                    ? LastPage(
                        mediaQuerySize: mediaQuerySize,
                        changeLoading: changeLoading,
                      )
                    // Next and Skip Button
                    : NextAndSkip(controller: controller),
              ),
              loading ? const Loader() : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class IconAndPageIndicator extends StatelessWidget {
  const IconAndPageIndicator({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            SvgPicture.asset(
              'assets/splash_screen/Logo.svg',
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 10),
            // App Name
            Text(
              'Musync',
              style: Theme.of(context).textTheme.h4.copyWith(
                    color: AppColors().onBackground,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Page Indicator
        KPageIndicator(
          controller: controller,
          itemCount: 4,
          inactiveDotWidth: 12,
          inactiveDotHeight: 12,
          activeDotHeight: 12,
          activeDotWidth: 70,
          dotSpacing: 15,
          trailing: false,
          activeColor: AppLightColor.primary,
          inactiveColor: AppLightColor.surfaceContainer,
        ),
      ],
    );
  }
}

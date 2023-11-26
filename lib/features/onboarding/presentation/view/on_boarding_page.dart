import 'package:flutter/material.dart';
import 'package:musync/core/common/custom_page_indicator.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/features/onboarding/presentation/widgets/illegal_page.dart';
import 'package:musync/features/onboarding/presentation/widgets/last_page.dart';
import 'package:musync/features/onboarding/presentation/widgets/next_and_skip.dart';
import 'package:musync/features/onboarding/presentation/widgets/page_builder.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  static PageController controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    List<dynamic> pages = [
      const OnBoardPageBuilder(
        lottieUrl: 'assets/lottie/4879-trumpet-music.json',
        title: 'Welcome to Musync',
        subtitle:
            'Seamlessly switch between your computer and phone without missing a beat.',
      ),
      const OnBoardPageBuilder(
        lottieUrl: 'assets/lottie/animation_lk5n0846.json',
        title: 'Listen to you library offline',
        subtitle:
            'Musync support playing offline media saved in you device or from the internet.',
      ),
      const IllegalPageBuilder(
        lottieUrl: 'assets/lottie/animation_lloun5s0.json',
        title: "Let's do something illegal.",
        subtitle: 'Toggle the illegal mode.',
      ),
      const OnBoardPageBuilder(
        lottieUrl:
            'assets/lottie/139537-boy-avatar-listening-music-animation.json',
        title: 'Get started now!!',
        subtitle:
            "Login to get started, if you don't have an account, you can create one.",
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
                      )
                    // Next and Skip Button
                    : NextAndSkip(controller: controller),
              ),
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
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset('assets/splash_screen/Logo.png'),
            ),
            const SizedBox(width: 10),
            // App Name
            Text(
              'Musync',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Page Indicator
        CustomPageIndicator(
          controller: controller,
          itemCount: 4,
          inactiveDotWidth: 12,
          inactiveDotHeight: 12,
          activeDotHeight: 12,
          activeDotWidth: 70,
          dotSpacing: 15,
          trailing: false,
          activeColor: KColors.accentColor,
          inactiveColor: KColors.greyColor,
        ),
      ],
    );
  }
}

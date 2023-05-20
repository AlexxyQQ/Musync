import 'package:flutter/material.dart';
import 'package:musync/src/common/custom_page_indicator.dart';
import 'package:musync/src/tab_onboarding/presentation/components/page_builder.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';

class TabOnBoardingPage extends StatefulWidget {
  const TabOnBoardingPage({super.key});

  @override
  State<TabOnBoardingPage> createState() => _TabOnBoardingPageState();
}

class _TabOnBoardingPageState extends State<TabOnBoardingPage> {
  static PageController controller = PageController();
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    try {
      controller.dispose();
    } catch (e) {
      return;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size mediaQuerySize = MediaQuery.of(context).size;
    List<dynamic> pages = [
      OnBoardPageBuilder(
        color: isDark ? blackColor : whiteColor,
        lottieUrl: 'assets/lottie/4879-trumpet-music.json',
        title: 'Welcome to Musync',
        subtitle:
            'Seamlessly switch between your computer and phone without missing a beat.',
      ),
      OnBoardPageBuilder(
        color: isDark ? blackColor : whiteColor,
        lottieUrl: 'assets/lottie/31634-turn-music-into-audience.json',
        title: 'Listen to you library offline',
        subtitle:
            'Musync support playing offline media saved in you device or from the internet.',
      ),
      OnBoardPageBuilder(
          color: isDark ? blackColor : whiteColor,
          lottieUrl:
              'assets/lottie/139537-boy-avatar-listening-music-animation.json',
          title: 'Get started now!!',
          subtitle:
              "Login to get started, if you don't have an account, you can create one."),
    ];
    return Scaffold(
      backgroundColor: isDark ? blackColor : whiteColor,
      body: SafeArea(
        child: SizedBox(
          width: mediaQuerySize.width,
          child: Stack(
            children: [
              PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 2;
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
                    isDark: isDark, controller: controller),
              ),
              // Get Started Offline and Terms and Conditions
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: isLastPage
                    // Get Started Offline and Terms and Conditions
                    ? const SizedBox()
                    // Next and Skip Button
                    : NextAndSkip(isDark: isDark, controller: controller),
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
    required this.isDark,
    required this.controller,
  });

  final bool isDark;
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
              style: textStyle(
                family: 'Sans',
                fontSize: 23,
                color: isDark ? whiteColor : blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Page Indicator
        CustomPageIndicator(
          controller: controller,
          itemCount: 3,
          dotWidth: 50,
          dotHeight: 12,
          dotSpacing: 15,
          trailing: true,
          activeColor: accentColor,
          inactiveColor: greyColor,
        ),
      ],
    );
  }
}

class NextAndSkip extends StatelessWidget {
  const NextAndSkip({
    super.key,
    required this.isDark,
    required this.controller,
  });

  final bool isDark;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: isDark ? blackColor : accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: isDark ? whiteColor : blackColor,
            ),
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 800),
                curve: Curves.linearToEaseOut,
              );
            },
            child: Text(
              'Next',
              style: textStyle(
                family: 'Sans',
                fontSize: 20,
                color: isDark ? blackColor : accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Skip Button
          TextButton(
            onPressed: () async {
              controller.animateToPage(2,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
            child: Text(
              'Skip',
              style: textStyle(
                family: 'Sans',
                fontSize: 20,
                color: isDark ? whiteColor : blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

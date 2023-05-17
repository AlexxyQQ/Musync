import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musync/src/common/custom_page_indicator.dart';
import 'package:musync/src/common/data/repositories/local_storage_repository.dart';
import 'package:musync/src/home/presentation/pages/home.dart';
import 'package:musync/src/music_library/presentation/pages/library_page.dart';
import 'package:musync/src/onBoarding/presentation/components/page_builder.dart';
import 'package:musync/src/utils/colors.dart';
import 'package:musync/src/utils/text_style.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
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
      resizeToAvoidBottomInset: false,
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
                    ? LastPage(
                        isDark: isDark,
                        mediaQuerySize: mediaQuerySize,
                      )
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

class LastPage extends ConsumerWidget {
  const LastPage(
      {super.key, required this.isDark, required this.mediaQuerySize});
  final bool isDark;
  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Terms and Conditions
        Text(
          "By continuing, you’re agreeing to \n Musync Privacy policy and Terms of use.",
          textAlign: TextAlign.center,
          style: textStyle(
            family: 'Sans',
            fontSize: 15,
            color: isDark ? whiteColor : blackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        // Get Started Offline
        TextButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            LocalStorageRepository().setValue(
                boxName: 'settings', key: "isFirstTime", value: false);
            LocalStorageRepository()
                .setValue(boxName: 'settings', key: "goHome", value: true);
            // await ref.read(songProvider).permission();
            navigator.pushNamedAndRemoveUntil(
              '/home',
              (route) => false,
              arguments: {
                "pages": [
                  // Home Page
                  const HomePage(),
                  // IDK
                  const Placeholder(),
                  // Library Page
                  const LibraryPage()
                ],
                "selectedIndex": 0,
              },
            );
          },
          child: Text(
            'Get Started Offline',
            style: textStyle(
              family: 'Sans',
              fontSize: 20,
              color: isDark ? whiteColor : blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Get Started Online
        InkWell(
          onTap: () async {
            final navigator = Navigator.of(context);
            LocalStorageRepository().setValue(
                boxName: 'settings', key: "isFirstTime", value: false);
            navigator.pushNamedAndRemoveUntil(
              '/welcome',
              (route) => false,
            );
          },
          child: Container(
            height: 67,
            width: mediaQuerySize.width,
            decoration: BoxDecoration(
              color: isDark ? whiteColor : blackColor,
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
                  style: textStyle(
                    family: 'Sans',
                    fontSize: 30,
                    color: isDark ? blackColor : whiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
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

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/features/authentication/widgets/main_auth_page.dart';
import 'package:musync/shared/components/custom_page_indicator.dart';
import 'package:musync/core/repositories/local_storage_repository.dart';
import 'package:musync/constants/constants.dart';
import 'package:musync/features/home/screens/home.dart';
import 'package:musync/features/library/screens/library_page.dart';
import 'package:musync/routes/routers.dart';
import 'package:musync/features/onBoarding/widgets/page_builder.dart';

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
    Size mediaQuerySize = MediaQuery.of(context).size;
    List<dynamic> pages = [
      const OnBoardPageBuilder(
        lottieUrl: 'assets/lottie/4879-trumpet-music.json',
        title: 'Welcome to Musync',
        subtitle:
            'Seamlessly switch between your computer and phone without missing a beat.',
      ),
      const OnBoardPageBuilder(
        lottieUrl: 'assets/lottie/31634-turn-music-into-audience.json',
        title: 'Listen to you library offline',
        subtitle:
            'Musync support playing offline media saved in you device or from the internet.',
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
          itemCount: 3,
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

class LastPage extends StatelessWidget {
  const LastPage({super.key, required this.mediaQuerySize});
  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Terms and Conditions
        Text(
          "By continuing, you’re agreeing to \n Musync Privacy policy and Terms of use.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 20),
        // Get Started Offline
        TextButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            GetIt.instance<LocalStorageRepository>().setValue(
              boxName: 'settings',
              key: "isFirstTime",
              value: false,
            );
            GetIt.instance<LocalStorageRepository>()
                .setValue(boxName: 'settings', key: "goHome", value: true);
            // await ref.read(songProvider).permission();
            navigator.pushNamedAndRemoveUntil(
              Routes.homeRoute,
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
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        // Get Started Online
        InkWell(
          onTap: () async {
            final navigator = Navigator.of(context);
            GetIt.instance<LocalStorageRepository>().setValue(
              boxName: 'settings',
              key: "isFirstTime",
              value: false,
            );
            navigator.pushNamedAndRemoveUntil(
              Routes.getStartedRoute,
              (route) => false,
            );
          },
          child: Container(
            height: 67,
            width: mediaQuerySize.width,
            decoration: const BoxDecoration(
              color: KColors.accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Get Started Now',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: KColors.blackColor,
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
    required this.controller,
  });

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
            style: Theme.of(context).textButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).brightness == Brightness.dark
                        ? KColors.accentColor
                        : KColors.blackColor,
                  ),
                ),
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 800),
                curve: Curves.linearToEaseOut,
              );
            },
            child: Text(
              'Next',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                  ),
            ),
          ),
          // Skip Button
          TextButton(
            onPressed: () async {
              controller.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/common/shimmers.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeFoldersShimmerEffect(),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, minHeight: 100),
              child: HomeAlbumsShimmerEffect(
                cardRoundness: 10,
                cardHeight: 215,
                cardWidth: 180,
                mqSize: MediaQuery.sizeOf(context),
                isCircular: false,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, minHeight: 100),
              child: HomeAlbumsShimmerEffect(
                cardRoundness: 500,
                cardHeight: 215,
                cardWidth: 180,
                mqSize: MediaQuery.sizeOf(context),
                isCircular: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

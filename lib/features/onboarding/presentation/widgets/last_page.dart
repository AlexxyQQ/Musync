import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/features/home/presentation/view/home.dart';
import 'package:musync/features/library/presentation/view/library_page.dart';

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
            GetIt.instance<HiveQueries>().setValue(
              boxName: 'settings',
              key: "isFirstTime",
              value: false,
            );
            GetIt.instance<HiveQueries>()
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
            GetIt.instance<HiveQueries>().setValue(
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

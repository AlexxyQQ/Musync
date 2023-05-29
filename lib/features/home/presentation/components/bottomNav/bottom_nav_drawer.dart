import 'package:flutter/material.dart';
import 'package:musync/core/constants.dart';

class KDrawer extends StatelessWidget {
  const KDrawer({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: isDark ? KColors.blackColor : KColors.whiteColor,
        child: Column(
          children: [
            // Drawer Header
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? KColors.offBlackColor : KColors.offWhiteColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Image
                  // CircleAvatar(
                  //   radius: 40,
                  //   backgroundImage: NetworkImage(
                  //     '${user?.profilePic}',
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  // Profile Name
                  Text(
                    // '${user?.username.toUpperCase()}',
                    'username',
                  ),
                ],
              ),
            ),
            // Drawer Items
            Expanded(
              child: ListView(
                children: [
                  // Drawer Item
                  ListTile(
                    leading: const Icon(Icons.home_rounded),
                    title: const Text('Home'),
                    onTap: () {},
                  ),
                  // Drawer Item
                  ListTile(
                    leading: const Icon(Icons.search_rounded),
                    title: const Text('Search'),
                    onTap: () {},
                  ),
                  // Drawer Item
                  ListTile(
                    leading: const Icon(Icons.library_music_rounded),
                    title: const Text('Library'),
                    onTap: () {},
                  ),
                  // Drawer Item
                  ListTile(
                    leading: const Icon(Icons.settings_rounded),
                    title: const Text('Settings'),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Ppp(),
                      //   ),
                      // );
                    },
                  ),
                  // Drawer Item
                  ListTile(
                    leading: const Icon(Icons.logout_rounded),
                    title: const Text('Logout'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

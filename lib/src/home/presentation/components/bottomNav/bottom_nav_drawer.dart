import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musync/src/authentication/data/providers/authentication_provider.dart';
import 'package:musync/src/authentication/data/providers/user_provider.dart';
import 'package:musync/src/common/data/repositories/local_storage_repository.dart';
import 'package:musync/src/utils/colors.dart';

class KDrawer extends ConsumerWidget {
  const KDrawer({
    super.key,
    required this.isDark,
  });

  final bool isDark;
  void signOut(WidgetRef ref, context) {
    ref.read(authenticationProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
    LocalStorageRepository().deleteValue(boxName: 'settings', key: 'goHome');
    Navigator.popAndPushNamed(context, "/welcome");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read and prind user Provider
    final user = ref.watch(userProvider);
    return Drawer(
      child: Container(
        color: isDark ? blackColor : whiteColor,
        child: Column(
          children: [
            // Drawer Header
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? offBlackColor : offWhiteColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      '${user?.profilePic}',
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Profile Name
                  Text(
                    '${user?.username.toUpperCase()}',
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
                    onTap: () {
                      signOut(ref, context);
                    },
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

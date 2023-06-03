import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/common/common_widgets/custom_snackbar.dart';
import 'package:musync/constants/constants.dart';
import 'package:musync/features/authentication/bloc/authentication_bloc.dart';
import 'package:musync/routes/routers.dart';

class KDrawer extends StatelessWidget {
  const KDrawer({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    var loggedUser = BlocProvider.of<AuthenticationBloc>(context).state.user;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Image
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: loggedUser != null
                        ? Image.network(loggedUser.profilePic)
                        : Image.asset('assets/default_profile.jpeg'),
                  ),

                  const SizedBox(height: 10),
                  // Profile Name
                  Text(
                    loggedUser?.username.toUpperCase() ?? 'Guest',
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
                    title: Text(
                      'Home',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {},
                  ),
                  // Drawer Item
                  ListTile(
                    leading: const Icon(Icons.search_rounded),
                    title: Text(
                      'Search',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {},
                  ),
                  // Drawer Item
                  ListTile(
                    leading: const Icon(Icons.library_music_rounded),
                    title: Text(
                      'Library',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {},
                  ),
                  // Drawer Item
                  ListTile(
                    leading: const Icon(Icons.settings_rounded),
                    title: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
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
                    title: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () async {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LogoutEvent());
                      kShowSnackBar(
                        'Logged Out',
                        context: context,
                      );
                      Navigator.popAndPushNamed(
                        context,
                        Routes.getStartedRoute,
                      );
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

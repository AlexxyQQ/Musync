import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/network/api/api.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/auth/presentation/state/bloc/authentication_bloc.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/features/home/data/data_source/music_remote_data_source.dart';
import 'package:musync/features/home/domain/use_case/music_query_use_case.dart';

class KDrawer extends StatefulWidget {
  const KDrawer({
    Key? key,
    required this.isDark,
    required this.syncTrue,
  }) : super(key: key);

  final bool isDark;
  final void Function() syncTrue;

  @override
  State<KDrawer> createState() => _KDrawerState();
}

class _KDrawerState extends State<KDrawer> {
  late MusicRemoteDataSource _musicRemoteDataSource;

  @override
  void initState() {
    super.initState();
    _musicRemoteDataSource = MusicRemoteDataSource(api: GetIt.instance<Api>());
  }

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final loggedUser = authenticationBloc.state.user;

    return Drawer(
      child: Container(
        color: widget.isDark ? KColors.blackColor : KColors.whiteColor,
        child: Column(
          children: [
            // Drawer Header
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.isDark
                    ? KColors.offBlackColor
                    : KColors.offWhiteColor,
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
                  // Sync
                  ListTile(
                    leading: const Icon(Icons.sync_rounded),
                    title: Text(
                      'Sync Online',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      _syncOnline();
                    },
                  ),
                  // Drawer Item
                  ListTile(
                    leading: const Icon(Icons.logout_rounded),
                    title: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      _logout(authenticationBloc);
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

  void _syncOnline() async {
    final allSongs = await GetIt.instance<MusicQueryUseCase>().getAllSongs();
    final token = await GetIt.instance<HiveQueries>().getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );

    kShowSnackBar(
      'Your Files are being checked',
      context: context,
      duration: Duration(seconds: 5),
    );

    await _musicRemoteDataSource.addSongs(songs: allSongs, token: token);
    await _musicRemoteDataSource.getAllSongs(token: token);

    kShowSnackBar(
      'Sync Completed',
      context: context,
      duration: const Duration(seconds: 5),
    );

    widget.syncTrue();
  }

  void _logout(AuthenticationBloc authenticationBloc) {
    authenticationBloc.add(LogoutEvent());
    kShowSnackBar('Logged Out', context: context);
    Navigator.popAndPushNamed(context, Routes.getStartedRoute);
  }
}

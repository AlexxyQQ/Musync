import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/utils/connectivity_check.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/features/home/presentation/state/music_query_state.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';

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
  late MusicQueryViewModel musicQueryBlocProvider;
  late AuthViewModel authenticationBlocProvider;

  @override
  void initState() {
    super.initState();
    musicQueryBlocProvider = BlocProvider.of<MusicQueryViewModel>(context);
    authenticationBlocProvider = BlocProvider.of<AuthViewModel>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialDataFetch();
    });
  }

  initialDataFetch() async {
    musicQueryBlocProvider.getAllSongs();
  }

  @override
  Widget build(BuildContext context) {
    final loggedUser = authenticationBlocProvider.state.loggedUser;
    return Drawer(
      child: Container(
        color: widget.isDark ? KColors.blackColor : KColors.whiteColor,
        child: Column(
          children: [
            // Drawer Header
            Container(
              height: 300,
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
                    child: loggedUser!.profilePic.contains('http')
                        ? Image.network(
                            loggedUser.profilePic,
                          )
                        : loggedUser.profilePic.contains('public')
                            ? Image.network(
                                "${ApiEndpoints.baseImageUrl}${loggedUser.profilePic}",
                              )
                            : Image.asset(loggedUser.profilePic),
                  ),

                  const SizedBox(height: 10),
                  // Profile Name
                  Text(
                    loggedUser.username.toUpperCase(),
                  ),
                  Text(
                    loggedUser.email,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'All Songs: ${musicQueryBlocProvider.state.songs.length} ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        ', Public Songs: ${musicQueryBlocProvider.state.songs.where((element) => element.isPublic ?? false).length}',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            // Drawer Items
            Column(
              children: [
                // Drawer Item
                ListTile(
                  leading: const Icon(Icons.home_rounded),
                  title: Text(
                    'Home',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                // Drawer Item
                ListTile(
                  leading: const Icon(Icons.settings_rounded),
                  title: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.settingRoute,
                    );
                  },
                ),
                // Sync
                BlocBuilder<MusicQueryViewModel, MusicQueryState>(
                  builder: (context, state) {
                    if (state.isUploading) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        kShowSnackBar("Uploading Songs", context: context);
                      });
                    }
                    return ListTile(
                      leading: const Icon(Icons.sync_rounded),
                      title: Text(
                        'Sync Online',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () async {
                        if (!state.isLoading &&
                            state.everything.isNotEmpty &&
                            await ConnectivityCheck.isServerup() &&
                            loggedUser.username != "Guest") {
                          _syncOnline(state);
                          Scaffold.of(context).closeDrawer();
                        }
                      },
                    );
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
                    _logout(authenticationBlocProvider);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _syncOnline(MusicQueryState state) async {
    final token = await GetIt.instance<HiveQueries>().getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    await musicQueryBlocProvider.addAllSongs(token: token);
    widget.syncTrue();
  }

  void _logout(AuthViewModel authViewModel) {
    authViewModel.logoutUser();
    kShowSnackBar('Logged Out', context: context);
    Navigator.popAndPushNamed(context, AppRoutes.getStartedRoute);
  }
}

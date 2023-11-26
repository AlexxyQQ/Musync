import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/network/hive/hive_queries.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late MusicQueryViewModel musicQueryBlocProvider;
  late AuthViewModel authenticationBlocProvider;

  @override
  void initState() {
    super.initState();
    musicQueryBlocProvider = BlocProvider.of<MusicQueryViewModel>(context);
    authenticationBlocProvider = BlocProvider.of<AuthViewModel>(context);
  }

  void _logout() async {
    await authenticationBlocProvider.logoutUser();
    kShowSnackBar('Logged Out', context: context);
    Navigator.popAndPushNamed(context, AppRoutes.getStartedRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              settingsAcountSection(context),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              settingsSongSection(context),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              settingsAboutSection(context),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              extraSettingsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Column settingsAboutSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        // App Version
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Version",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              '1.0.0',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: KColors.greyColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // About Us
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Us",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Know more about us',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: KColors.greyColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Privacy Policy
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Know more about our privacy policy',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: KColors.greyColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Terms and Conditions
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms and Conditions",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Know more about our terms and conditions',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: KColors.greyColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Column settingsSongSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Songs',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        // All Songs
        InkWell(
          onTap: () async {
            Navigator.pushNamed(context, AppRoutes.manageAllSongsRoute);
            await context.read<MusicQueryViewModel>().getAllSongs();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Songs",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'View and manage all your songs',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: KColors.greyColor,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Public Songs
        authenticationBlocProvider.state.loggedUser!.email != "Guest"
            ? InkWell(
                onTap: () async {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.manageAllPublicSongsRoute,
                  );
                  await context
                      .read<MusicQueryViewModel>()
                      .getUserPublicSongs();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Public Songs",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'View and manage all Public songs',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: KColors.greyColor,
                          ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Column extraSettingsSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
// Delete Account
        authenticationBlocProvider.state.loggedUser!.email != "Guest"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delete Account',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Delete Account',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          content: Text(
                            'Are you sure you want to delete your account?',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await authenticationBlocProvider.deleteUser();
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.loginRoute,
                                  (route) => false,
                                );
                              },
                              child: Text(
                                'Delete',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 6),
        // Logout
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Logout',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            IconButton(
              onPressed: () async {
                _logout();
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   Routes.login,
                //   (route) => false,
                // );
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column settingsAcountSection(BuildContext context) {
    File? image0;
    Future browseImage(ImageSource imageSource) async {
      try {
        final image = await ImagePicker().pickImage(source: imageSource);
        if (image != null) {
          setState(() {
            image0 = File(image.path);
          });
          await authenticationBlocProvider.uploadProfilePic(
            path: image0!.path,
          );
        } else {
          return;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    // show a model bottom sheet to choose the image source
    void showImageSourceDialog() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () {
                    browseImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    browseImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            // User Profile Image
            GestureDetector(
              onTap: () {
                authenticationBlocProvider.state.loggedUser!.email != "Guest"
                    ? showImageSourceDialog()
                    : null;
              },
              child: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: authenticationBlocProvider.state.loggedUser!.profilePic
                        .contains('http')
                    ? Image.network(
                        authenticationBlocProvider.state.loggedUser!.profilePic,
                      )
                    : authenticationBlocProvider.state.loggedUser!.profilePic
                            .contains('public')
                        ? Image.network(
                            "${ApiEndpoints.baseImageUrl}${authenticationBlocProvider.state.loggedUser!.profilePic}",
                          )
                        : Image.asset(
                            authenticationBlocProvider
                                .state.loggedUser!.profilePic,
                          ),
              ),
            ),
            const SizedBox(width: 18),
            // User Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authenticationBlocProvider.state.loggedUser!.username
                      .toUpperCase(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Click to change profile picture',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: KColors.greyColor,
                      ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Account',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Text(
          "Email",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        Text(
          authenticationBlocProvider.state.loggedUser!.email,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: KColors.greyColor,
              ),
        ),
        authenticationBlocProvider.state.loggedUser!.username != "Guest"
            ? const SizedBox(height: 12)
            : const SizedBox.shrink(),
        authenticationBlocProvider.state.loggedUser!.username != "Guest"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Biometric",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Allow login with biometric',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: KColors.greyColor,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Switch(
                    value: authenticationBlocProvider
                        .state.allowLoginWithBiometric,
                    onChanged: (value) {
                      GetIt.I<HiveQueries>().setValue(
                        boxName: 'users',
                        key: 'allowBiometric',
                        value: value,
                      );
                      if (value &&
                          authenticationBlocProvider
                                  .state.loggedUser!.username !=
                              "Guest") {
                        GetIt.I<HiveQueries>().setValue(
                          boxName: 'users',
                          key: 'anotherToken',
                          value: authenticationBlocProvider
                              .state.loggedUser!.token,
                        );

                        kShowSnackBar(
                          value
                              ? 'Biometric login enabled'
                              : 'Biometric login disabled',
                          context: context,
                        );
                      }
                    },
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

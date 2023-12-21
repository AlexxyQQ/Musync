import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/custom_widgets/custom_form_filed.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';
import 'package:musync/features/home/domain/entity/artist_entity.dart';
import 'package:musync/features/home/domain/entity/folder_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:musync/features/home/presentation/widgets/home_artist_component.dart';
import 'package:musync/features/home/presentation/widgets/home_album_component.dart';
import 'package:musync/features/home/presentation/widgets/home_recently_played_component.dart';
import 'package:musync/features/home/presentation/widgets/home_todays_mix_component.dart';
import 'package:musync/features/home/presentation/widgets/home_top_buttons-component.dart';

import '../../domain/entity/album_entity.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, HomeState>(
      builder: (context, state) {
        log('fetchedSongs: ${state.isSuccess}', name: 'getAllAlbums');
        log('fetchedSongs: ${state.artists}', name: 'getAllArtist');
        log('fetchedSongs: ${state.folders}', name: 'getAllFolders');
        log('fetchedSongs: ${state.songs}', name: 'getAllSongs');

        final bool noAnyData = state.albums.isEmpty &&
            state.artists.isEmpty &&
            state.folders.isEmpty &&
            state.songs.isEmpty &&
            !state.isLoading;

        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
              child: KTextFormField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                hintText: state.isLoading
                    ? "Songs Loaded: ${state.count}"
                    : 'Search...........',
                contentStyle: Theme.of(context).textTheme.mBM.copyWith(
                      color: AppColors().onSurface,
                    ),
                hintTextStyle: Theme.of(context).textTheme.lBM.copyWith(
                      color: AppColors().onSurfaceVariant,
                    ),
                errorTextStyle: Theme.of(context).textTheme.mC.copyWith(
                      color: AppColors().onErrorContainer,
                    ),
                prefixIcon: Icon(
                  Icons.menu_rounded,
                  color: AppColors().onSurfaceVariant,
                ),
                fillColor: AppColors().surfaceContainer,
              ),
            ),
            leadingWidth: MediaQuery.of(context).size.width,
            toolbarHeight: 80.h,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TopButtons(),
                  SizedBox(height: 8.h),
                  const HomeRecentlyPayedComponent(),
                  SizedBox(height: 8.h),
                  const HomeTodaysMixComponent(),
                  SizedBox(height: 8.h),
                  const HomeAlbumComponent(),
                  SizedBox(height: 8.h),
                  const HomeArtistComponent(),
                  noAnyData
                      ? const Center(
                          child: Text("No Data Found"),
                        )
                      : SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

albumPage(BuildContext context, List<AlbumEntity> albums) {
  return ListView.builder(
    itemCount: albums.length,
    itemBuilder: (context, index) {
      final album = albums[index];
      return InkWell(
        onTap: () {
          // Show a modal bottom sheet when the widget is tapped.
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ListView.builder(
                itemCount: album.songs?.length ?? 0,
                itemBuilder: (context, indexw) {
                  final song = album.songs?[indexw];
                  return ListTile(
                    title: Text(
                      song?.title ?? '',
                      style: ThemeData()
                          .textTheme
                          .bBL
                          .copyWith(color: AppColors().onBackground),
                    ),
                    subtitle: Text(
                      "${song?.artist}",
                      style: ThemeData()
                          .textTheme
                          .bBL
                          .copyWith(color: AppColors().onBackground),
                    ),
                  );
                },
              );
            },
          );
        },
        child: ListTile(
          title: Text(
            album.album,
            style: ThemeData()
                .textTheme
                .bBL
                .copyWith(color: AppColors().onBackground),
          ),
          subtitle: Text(
            "${album.numOfSongs}",
            style: ThemeData()
                .textTheme
                .bBL
                .copyWith(color: AppColors().onBackground),
          ),
        ),
      );
    },
  );
}

artistPage(BuildContext context, List<ArtistEntity> artits) {
  return ListView.builder(
    itemCount: artits.length,
    itemBuilder: (context, index) {
      final artist = artits[index];
      return InkWell(
        onTap: () {
          // Show a modal bottom sheet when the widget is tapped.
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ListView.builder(
                itemCount: artits[index].songs?.length ?? 0,
                itemBuilder: (context, indexw) {
                  final song = artist.songs?[indexw];
                  return ListTile(
                    title: Text(
                      song?.title ?? '',
                      style: ThemeData()
                          .textTheme
                          .bBL
                          .copyWith(color: AppColors().onBackground),
                    ),
                    subtitle: Text(
                      "${song?.artist}",
                      style: ThemeData()
                          .textTheme
                          .bBL
                          .copyWith(color: AppColors().onBackground),
                    ),
                  );
                },
              );
            },
          );
        },
        child: ListTile(
          title: Text(
            artist.artist,
            style: ThemeData()
                .textTheme
                .bBL
                .copyWith(color: AppColors().onBackground),
          ),
          subtitle: Text(
            "${artist.songs?.length ?? 0}",
            style: ThemeData()
                .textTheme
                .bBL
                .copyWith(color: AppColors().onBackground),
          ),
        ),
      );
    },
  );
}

folderPage(BuildContext context, List<FolderEntity> folders) {
  return ListView.builder(
    itemCount: folders.length,
    itemBuilder: (context, index) {
      final folder = folders[index];
      return InkWell(
        onTap: () {
          // Show a modal bottom sheet when the widget is tapped.
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ListView.builder(
                itemCount: folders[index].songs?.length ?? 0,
                itemBuilder: (context, index) {
                  final song = folder.songs?[index];
                  return ListTile(
                    title: Text(
                      song?.title ?? '',
                      style: ThemeData()
                          .textTheme
                          .bBL
                          .copyWith(color: AppColors().onBackground),
                    ),
                    subtitle: Text(
                      "${song?.artist}",
                      style: ThemeData()
                          .textTheme
                          .bBL
                          .copyWith(color: AppColors().onBackground),
                    ),
                  );
                },
              );
            },
          );
        },
        child: ListTile(
          title: Text(
            folder.folderName,
            style: ThemeData()
                .textTheme
                .bBL
                .copyWith(color: AppColors().onBackground),
          ),
          subtitle: Text(
            "${folder.songs?.length ?? 0}",
            style: ThemeData()
                .textTheme
                .bBL
                .copyWith(color: AppColors().onBackground),
          ),
        ),
      );
    },
  );
}

songsPage(BuildContext context, List<SongEntity> songs) {
  return ListView.builder(
    itemCount: songs.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          songs[index].title,
          style: ThemeData()
              .textTheme
              .bBL
              .copyWith(color: AppColors().onBackground),
        ),
        subtitle: Text(
          "${songs[index].artist}",
          style: ThemeData()
              .textTheme
              .bBL
              .copyWith(color: AppColors().onBackground),
        ),
      );
    },
  );
}

// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [Placeholder()],
//           ),
//         ),
//       ),
//     );
//   }
// }

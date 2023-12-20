import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';
import 'package:musync/features/home/domain/entity/artist_entity.dart';
import 'package:musync/features/home/domain/entity/folder_entity.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:musync/features/home/presentation/widgets/home_artist_component.dart';
import 'package:musync/features/home/presentation/widgets/home_folder_component.dart';
import 'package:musync/features/home/presentation/widgets/home_album_component.dart';
import 'package:musync/features/home/presentation/widgets/home_recently_played_component.dart';
import 'package:musync/features/home/presentation/widgets/home_todays_mix_component.dart';
import 'package:musync/features/home/presentation/widgets/home_top_buttons-component.dart';

import '../../domain/entity/album_entity.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            body: Center(child: Text('Songs Loaded: ${state.count}')),
          );
        } else if (state.isSuccess) {
          if (state.songs!.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Music',
                  style: ThemeData()
                      .textTheme
                      .bBL
                      .copyWith(color: AppColors().onBackground),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<QueryCubit>(context).init();
                    },
                    icon: const Icon(
                      Icons.refresh,
                    ),
                  ),
                ],
              ),
              body: Center(
                child: Text(
                  'No Songs',
                  style: ThemeData()
                      .textTheme
                      .bBL
                      .copyWith(color: AppColors().onBackground),
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Music',
                style: ThemeData()
                    .textTheme
                    .bBL
                    .copyWith(color: AppColors().onBackground),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<QueryCubit>(context).init();
                  },
                  icon: const Icon(
                    Icons.refresh,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        'THE UI IS SUSCEPTIBLE TO CHANGE',
                        style: Theme.of(context)
                            .textTheme
                            .bC
                            .copyWith(color: AppColors().error),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const TopButtons(),
                        const SizedBox(height: 12),
                        HomeRecentlyPayedComponent(),
                        HomeTodaysMixComponent(),
                        const HomeAlbumComponent(),
                        const HomeArtistComponent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.error != null) {
          return Scaffold(
            body: Center(child: Text('Error: ${state.error!.message}')),
          );
        }
        return Container();
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

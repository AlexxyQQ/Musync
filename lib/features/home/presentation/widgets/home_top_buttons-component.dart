import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/route/routes.dart';
import 'package:musync/core/common/custom_widgets/custom_buttom.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:musync/features/home/presentation/widgets/song_list_page.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_cubit.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        // Favorite Button
        KButton(
          onPressed: () {},
          label: 'Favorite',
          backgroundColor: AppDarkColor.primary,
          foregroundColor: AppDarkColor.onPrimary,
          borderRadius: 12,
          svg: 'assets/iconography/heart-outline.svg',
          fixedSize: const Size(150, 30),
        ),
        // Recent Button
        KButton(
          onPressed: () async {
            final nav = Navigator.of(context);
            await BlocProvider.of<QueryCubit>(context).getRecentlyPlayedSongs();
            nav.push(
              MaterialPageRoute(
                builder: (context) => SongsListPage(
                  songs: BlocProvider.of<QueryCubit>(context)
                          .state
                          .recentlyPlayed
                          ?.songs ??
                      [],
                ),
              ),
            );
          },
          label: 'Recent',
          backgroundColor: AppDarkColor.secondary,
          foregroundColor: AppDarkColor.onSecondary,
          borderRadius: 12,
          svg: 'assets/iconography/recent.svg',
          fixedSize: const Size(150, 30),
        ),
        // Folder Button
        KButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.folderPageRoute);
          },
          label: 'Folder',
          backgroundColor: AppDarkColor.tertiary,
          foregroundColor: AppDarkColor.onTertiary,
          borderRadius: 12,
          svg: 'assets/iconography/music-folder-outline.svg',
          fixedSize: const Size(150, 30),
        ),
        //  Shuffle Button
        KButton(
          onPressed: () {
            if (BlocProvider.of<QueryCubit>(context).state.songs.isNotEmpty) {
              BlocProvider.of<NowPlayingCubit>(context).clearQueue();
              BlocProvider.of<NowPlayingCubit>(context).setSongs(
                songs: BlocProvider.of<QueryCubit>(context).state.songs,
                song: BlocProvider.of<QueryCubit>(context).state.songs.first,
                context: context,
              );
              BlocProvider.of<NowPlayingCubit>(context).shuffle();
              BlocProvider.of<QueryCubit>(context).updateRecentlyPlayedSongs(
                song: BlocProvider.of<QueryCubit>(context).state.songs.first,
              );
            }
          },
          label: 'Shuffle',
          backgroundColor: AppDarkColor.error,
          foregroundColor: AppDarkColor.onError,
          borderRadius: 12,
          svg: 'assets/iconography/shuffle.svg',
          fixedSize: const Size(150, 30),
        ),
      ],
    );
  }
}

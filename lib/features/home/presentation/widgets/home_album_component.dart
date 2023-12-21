import 'dart:io';

import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:shimmer/shimmer.dart';

class HomeAlbumComponent extends StatelessWidget {
  const HomeAlbumComponent({
    super.key,
  });

  Widget _buildShimmerEffect(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors(inverseDarkMode: true).surfaceDim,
      highlightColor: AppColors(inverseDarkMode: true).surfaceContainerHigh,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Number of shimmer items you want to show
        itemBuilder: (_, __) => Container(
          height: 160,
          width: 160,
          margin: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
          child: Stack(
            children: [
              Positioned(
                left: 8,
                top: 8,
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors(inverseDarkMode: true)
                        .surfaceDim
                        .withOpacity(0.5),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                bottom: 12,
                child: Container(
                  height: 90,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors(inverseDarkMode: true)
                              .surfaceContainerLowest
                              .withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 100,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors(inverseDarkMode: true)
                              .surfaceContainerLowest
                              .withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return SizedBox(
            height: 160,
            width: MediaQuery.of(context).size.width,
            child: _buildShimmerEffect(context),
          );
        } else if (state.isSuccess) {
          if (state.albums.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return Column(
              children: [
                // Section Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Albums",
                      style: Theme.of(context).textTheme.h5.copyWith(
                            color: AppColors().onBackground,
                          ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Go to all folders page
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                // List Section
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      // Fetching album cover from the list of songs
                      var albumCover = state.albums[index].songs!
                          .firstWhere(
                            (song) => song.albumArt != null,
                          )
                          .albumArt;

                      return Container(
                        height: 300,
                        width: 150,
                        alignment: Alignment.bottomLeft,
                        margin:
                            const EdgeInsets.only(bottom: 8, right: 8, left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Album Cover
                            Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: albumCover != null
                                      ? Image.file(File(albumCover)).image
                                      : const AssetImage(
                                          'assets/images/default_cover.jpg',
                                        ), // Default cover
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Album Details
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  state.albums[index].album,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style:
                                      Theme.of(context).textTheme.mBL.copyWith(
                                            color: AppColors().onBackground,
                                          ),
                                ),
                                Text(
                                  "${state.albums[index].artist}",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style:
                                      Theme.of(context).textTheme.lBS.copyWith(
                                            color: AppColors().onBackground,
                                          ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                    // only show 10 items
                    itemCount:
                        state.albums.length > 10 ? 10 : state.albums.length,
                  ),
                ),
              ],
            );
          }
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      },
    );
  }
}

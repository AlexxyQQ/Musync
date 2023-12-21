import 'dart:developer';
import 'dart:io';

import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:shimmer/shimmer.dart';

class HomeArtistComponent extends StatelessWidget {
  const HomeArtistComponent({
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
          width: 120,
          margin: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
          child: Stack(
            children: [
              Positioned(
                left: 8,
                top: 8,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: AppColors(inverseDarkMode: true)
                        .surfaceDim
                        .withOpacity(0.5),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 12,
                child: Container(
                  width: 80,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors(inverseDarkMode: true)
                        .surfaceContainerLowest
                        .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
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
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: _buildShimmerEffect(context),
          );
        } else if (state.isSuccess) {
          if (state.artists.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return Column(
              children: [
                // Section Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Artists",
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
                      var albumCover = state.artists[index].songs!
                          .firstWhere(
                            (song) => song.albumArt != null,
                          )
                          .albumArt;

                      return Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            // Album Cover
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                image: DecorationImage(
                                  image: albumCover != null
                                      ? Image.file(
                                          File(albumCover),
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/splash_screen/icon.png',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ).image
                                      : const AssetImage(
                                          'assets/splash_screen/icon.png',
                                        ), // Default cover
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Album Details
                            Text(
                              state.artists[index].artist,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.mBM.copyWith(
                                    color: AppColors().onBackground,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }),
                    // only show 10 items
                    itemCount:
                        state.artists.length > 10 ? 10 : state.artists.length,
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
import 'dart:io' as io;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/constants/colors/primitive_colors.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/app_text_theme_extension.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shimmer/shimmer.dart';

class HomeRecentlyPayedComponent extends StatefulWidget {
  const HomeRecentlyPayedComponent({
    super.key,
  });

  @override
  State<HomeRecentlyPayedComponent> createState() =>
      _HomeRecentlyPayedComponentState();
}

class _HomeRecentlyPayedComponentState
    extends State<HomeRecentlyPayedComponent> {
  Map<String, Color> albumArtColors = {}; // Map to store colors for each album

  Future<void> _extractAlbumArtColor(String path) async {
    if (!albumArtColors.containsKey(path)) {
      // Check if color is already extracted
      try {
        final Uint8List fileData = await io.File(path).readAsBytes();
        final ui.Codec codec = await ui.instantiateImageCodec(fileData);
        final ui.FrameInfo frameInfo = await codec.getNextFrame();

        final PaletteGenerator paletteGenerator =
            await PaletteGenerator.fromImage(frameInfo.image);

        setState(() {
          albumArtColors[path] =
              paletteGenerator.dominantColor?.color ?? AppColors().primary;
        });
      } catch (e) {
        print("Error extracting color: $e");
      }
    }
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors(inverseDarkMode: true).surfaceDim,
      highlightColor: AppColors(inverseDarkMode: true).surfaceContainerHigh,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Number of shimmer items you want to show
        itemBuilder: (_, __) => Container(
          width: 250,
          height: 110,
          margin: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                width: double.infinity,
                height: 94,
                decoration: BoxDecoration(
                  color: AppColors(inverseDarkMode: true)
                      .surfaceDim
                      .withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Positioned(
                right: 12,
                top: 15,
                child: Container(
                  height: 80,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors(inverseDarkMode: true)
                        .surfaceContainerLowest
                        .withOpacity(0.8),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 25,
                child: Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors(inverseDarkMode: true)
                              .surfaceContainerLowest
                              .withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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
    return Column(
      children: [
        // Section Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recently Played",
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
        BlocBuilder<QueryCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return SizedBox(height: 118, child: _buildShimmerEffect(context));
            } else if (state.isSuccess) {
              if (state.albums!.isEmpty) {
                return const Center(
                  child: Text('No data'),
                );
              } else {
                return SizedBox(
                  height: 118,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      // Fetching album cover from the list of songs
                      var albumCover = state.albums![index].songs!
                          .firstWhere(
                            (song) => song.albumArt != null,
                          )
                          .albumArt;

                      if (albumCover != null) {
                        _extractAlbumArtColor(albumCover);
                      }

                      Color currentColor =
                          albumArtColors[albumCover] ?? AppColors().primary;

                      return Container(
                        width: 250,
                        height: 110,
                        margin:
                            const EdgeInsets.only(bottom: 8, right: 8, left: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            // Album Cover
                            Positioned(
                              right: 0,
                              child: Container(
                                height: 110,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: albumCover != null
                                        ? Image.file(io.File(albumCover)).image
                                        : const AssetImage(
                                            'assets/images/default_cover.jpg',
                                          ), // Default cover
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            // Gradient
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 110,
                                width: 500,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  // LinearGradient
                                  gradient: LinearGradient(
                                    tileMode: TileMode.clamp,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      currentColor,
                                      currentColor,
                                      currentColor.withOpacity(0.2),
                                      currentColor.withOpacity(0.1),
                                      Colors.transparent,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Play Button
                            Positioned(
                              left: 160,
                              top: (110 / 2) - 15,
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(500),
                                  color:
                                      PrimitiveColors.greyV100.withOpacity(0.5),
                                ),
                                child: const Icon(
                                  Icons.play_arrow_rounded,
                                  size: 16,
                                  color: PrimitiveColors.greyV900,
                                ),
                              ),
                            ),
                            // Song Name and Artist
                            Positioned(
                              left: 8,
                              top: 25,
                              child: Container(
                                height: 60,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.albums![index].songs!.first.title,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .mBL
                                          .copyWith(
                                            color: AppDarkColor.onBackground,
                                          ),
                                    ),
                                    Text(
                                      "${state.albums![index].artist}",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .lBS
                                          .copyWith(
                                            color: AppDarkColor.onBackground,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    // only show 10 items
                    itemCount:
                        state.albums!.length > 10 ? 10 : state.albums!.length,
                  ),
                );
              }
            } else {
              return const Center(
                child: Text('No data'),
              );
            }
          },
        ),
      ],
    );
  }
}

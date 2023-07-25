import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/api_endpoints.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/nowplaying/presentation/state/now_playing_state.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  Color? albumArtColor; // Variable to store the extracted color

  Future<void> _extractAlbumArtColor(NowPlayingState state) async {
    if (state.currentSong.albumArtUrl != null) {
      try {
        final imageProvider = NetworkImage(state.currentSong.albumArtUrl!);
        final PaletteGenerator paletteGenerator =
            await PaletteGenerator.fromImageProvider(imageProvider);

        setState(() {
          albumArtColor = paletteGenerator.dominantColor?.color;
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<NowPlayingViewModel, NowPlayingState>(
      builder: (context, state) {
        _extractAlbumArtColor(state);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            title: Text(
              "Share",
              style: TextStyle(
                color: isDark ? KColors.offWhiteColor : KColors.offBlackColor,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: KColors.accentColor,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Toggle make public switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Make Public'),
                    state.currentSong.serverUrl != null
                        ? Switch(
                            value: state.currentSong.isPublic!,
                            onChanged: (value) async {
                              // Call the togglePublic method and pass the opposite value of isPublic
                              await context
                                  .read<NowPlayingViewModel>()
                                  .tooglePublic(
                                    songID: state.currentSong.id,
                                    isPublic: !(state.currentSong.isPublic!),
                                  );
                            },
                          )
                        : const Text(
                            'Offline Song',
                          ), // Display a message if server URL is not available
                  ],
                ),
                const SizedBox(height: 16.0),
                // Shared Song Cover
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // make this color dynamic according to the color of the album art
                    color: albumArtColor ?? KColors.blackColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isDark
                                  ? KColors.offBlackColor
                                  : KColors.offBlackColor,
                            ),
                            // Add Album Art Here
                            child: state.currentSong.albumArtUrl == null ||
                                    state.currentSong.albumArtUrl == ''
                                ? QueryArtworkWidget(
                                    artworkBorder: BorderRadius.circular(20),
                                    id: state.currentSong.id,
                                    nullArtworkWidget: const Icon(
                                      Icons.music_note_rounded,
                                      size: 40,
                                      color: KColors.accentColor,
                                    ),
                                    type: ArtworkType.AUDIO,
                                    errorBuilder: (p0, p1, p2) {
                                      return const Icon(
                                        Icons.music_note_rounded,
                                        color: KColors.accentColor,
                                      );
                                    },
                                  )
                                : QueryArtworkFromApi(
                                    borderRadius: BorderRadius.circular(20),
                                    data: state.queue,
                                    index: state.currentIndex,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Copy Link Button

                state.currentSong.isPublic == false
                    ? const SizedBox()
                    : ElevatedButton(
                        onPressed: () {
                          _copyToClipboard(
                            "${ApiEndpoints.baseImageUrl}${state.queue[state.currentIndex].serverUrl}",
                          );
                          kShowSnackBar(
                            'Link copied to clipboard',
                            context: context,
                          );
                        },
                        child: const Text('Copy Link'),
                      ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper function to copy the link to clipboard
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}

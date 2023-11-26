import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/home/presentation/state/music_query_state.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ManageAllSongsView extends StatefulWidget {
  const ManageAllSongsView({super.key});

  @override
  State<ManageAllSongsView> createState() => _ManageAllSongsViewState();
}

class _ManageAllSongsViewState extends State<ManageAllSongsView> {
  final scrollController = ScrollController();

  Future<void> deleteFile(
      SongEntity song, MusicQueryViewModel musicQuery,) async {
    try {
      final file = File(song.data);
      if (await file.exists()) {
        await musicQuery.deleteSong(song: song);
        Navigator.pop(context);
        kShowSnackBar(
          'Song deleted successfully',
          context: context,
        );
      } else {
        kShowSnackBar(
          'File not found: ${file.path}',
          context: context,
        );
      }
    } catch (e) {
      kShowSnackBar(
        'Error deleting file: $e',
        context: context,
      );
    }
  }

  Future<void> deleteFileDialog(SongEntity song) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Song'),
          content: const Text('Are you sure you want to delete this song?'),
          actions: [
            TextButton(
              onPressed: () async {
                await deleteFile(song, context.read<MusicQueryViewModel>());
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    return BlocBuilder<MusicQueryViewModel, MusicQueryState>(
      builder: (context, state) {
        final song = state.songs;
        return Scaffold(
          appBar: AppBar(
            title: const Text('All Songs'),
            centerTitle: true,
            toolbarHeight: 80,
          ),
          body: Scrollbar(
            controller: scrollController,
            child: ListView.builder(
              controller: scrollController,
              itemCount: song.length,
              itemBuilder: (context, index) {
                final ms = song[index].duration!;
                final duration = Duration(milliseconds: ms);
                final minutes = duration.inMinutes;
                final seconds = duration.inSeconds.remainder(60);

                return InkWell(
                  onTap: () async {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 5,
                    ),
                    child: ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: song[index].albumArtUrl == null ||
                                song[index].albumArtUrl == ''
                            ? QueryArtworkWidget(
                                id: song[index].id,
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
                                data: song,
                                index: index,
                              ),
                      ),
                      title: SizedBox(
                        width: mqSize.width * 0.7,
                        child: Text(
                          song[index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          text:
                              '${song[index].artist} • ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          // await ff();
                          await deleteFileDialog(song[index]);
                        },
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          size: 30,
                          color: KColors.accentColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

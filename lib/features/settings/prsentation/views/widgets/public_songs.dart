// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/features/home/presentation/viewmodel/music_query_view_model.dart';
import 'package:musync/features/nowplaying/presentation/state/now_playing_state.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ManagePublicSongsView extends StatefulWidget {
  const ManagePublicSongsView({super.key});

  @override
  State<ManagePublicSongsView> createState() => _ManagePublicSongsViewState();
}

class _ManagePublicSongsViewState extends State<ManagePublicSongsView> {
  late final MusicQueryViewModel musicQuery;
  final scrollController = ScrollController();

  initialDataFetch() async {
    await musicQuery.getAllSongs();
  }

  @override
  void initState() {
    super.initState();
    musicQuery = BlocProvider.of<MusicQueryViewModel>(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    initialDataFetch();
    final mqSize = MediaQuery.of(context).size;
    final song = musicQuery.state.songs
        .where((element) => element.isPublic ?? false)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Public Songs'),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: song.isEmpty
          ? const Center(
              child: Text(
                'No Public Songs Found',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Scrollbar(
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
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        ),
                        trailing:
                            BlocBuilder<NowPlayingViewModel, NowPlayingState>(
                          builder: (context, state) {
                            return Switch(
                              value: song[index].isPublic!,
                              onChanged: (value) async {
                                // Call the togglePublic method and pass the opposite value of isPublic
                                await context
                                    .read<NowPlayingViewModel>()
                                    .tooglePublic(
                                      songID: song[index].id,
                                      isPublic: !(song[index].isPublic!),
                                    );
                                await context
                                    .read<MusicQueryViewModel>()
                                    .getAllSongs();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

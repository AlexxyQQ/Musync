import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueueView extends StatelessWidget {
  final List<SongEntity> songList;
  const QueueView({super.key, required this.songList});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        return Container(
          height: songList.isEmpty
              ? 200.h
              : MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: AppColors().surfaceContainerHighest,
          ),
          child: Scaffold(
            backgroundColor: AppColors().surfaceContainerHighest,
            appBar: AppBar(
              leadingWidth: MediaQuery.of(context).size.width,
              // Gradient Container
              leading: Container(
                  height: 24.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        AppColors().surfaceContainerLowest,
                        AppColors().surfaceContainerHighest,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //? Queue Title
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'Queue',
                          style: Theme.of(context).textTheme.bBL.copyWith(
                                color: AppColors().onSurface,
                                letterSpacing: 1,
                              ),
                        ),
                      ),
                      //? Clear Queue Button
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: IconButton(
                          onPressed: () {
                            context.read<NowPlayingCubit>().clearQueue();
                          },
                          icon: Icon(
                            Icons.clear_rounded,
                            color: AppColors().onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),),
            ),
            body: songList.isEmpty
                ? Center(
                    child: Text(
                      'Queue is empty',
                      style: Theme.of(context).textTheme.bBM.copyWith(
                            color: AppColors().onSurface,
                            letterSpacing: 1,
                          ),
                    ),
                  )
                : Scrollbar(
                    controller: controller,
                    radius: const Radius.circular(10),
                    thickness: 10,
                    interactive: true,
                    child: ListView.builder(
                      controller: controller,
                      itemCount: songList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: state.queue![index].albumArtUrl == null ||
                                    state.queue![index].albumArtUrl == ''
                                ? QueryArtworkWidget(
                                    id: state.queue![index].id,
                                    nullArtworkWidget: const Icon(
                                      Icons.music_note_rounded,
                                      size: 40,
                                      color: PrimitiveColors.primary500,
                                    ),
                                    type: ArtworkType.AUDIO,
                                    errorBuilder: (p0, p1, p2) {
                                      return const Icon(
                                        Icons.music_note_rounded,
                                        color: PrimitiveColors.primary500,
                                      );
                                    },
                                  )
                                : Image.network(
                                    state.queue![index].albumArtUrl!,
                                    fit: BoxFit.cover,
                                  ),
                            // : QueryArtworkFromApi(
                            //     data: state.queue,
                            //     index: index,
                            //   ),
                          ),
                          title: Text(
                            state.queue![index].title,
                            style: Theme.of(context).textTheme.mBM.copyWith(
                                  color: state.currentIndex == index
                                      ? AppColors(inverseDarkMode: true)
                                          .primaryContainer
                                      : AppColors().onSurface,
                                ),
                          ),
                          subtitle: Text(
                            state.queue![index].artist!,
                            style: Theme.of(context).textTheme.lBS.copyWith(
                                  color: state.currentIndex == index
                                      ? AppColors(inverseDarkMode: true)
                                          .primaryContainer
                                      : AppColors().onSurface,
                                ),
                          ),
                          onTap: () {
                            // context.read<NowPlayingViewModel>().playAll(
                            //       songs: songList,
                            //       index: index,
                            //     );
                            // Navigator.pushNamed(context, Routers.nowPlaying);
                          },
                        );
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}

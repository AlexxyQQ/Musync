import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_state.dart';

class LyricsView extends StatelessWidget {
  final SongEntity song;
  const LyricsView({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
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
                        'Lyrics',
                        style: Theme.of(context).textTheme.bBL.copyWith(
                              color: AppColors().onSurface,
                              letterSpacing: 1,
                            ),
                      ),
                    ),
                    //? Expand Lyrics Button
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const LyricsViewBig(),
                          );
                        },
                        icon: Icon(
                          Icons.fullscreen_outlined,
                          color: AppColors().onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body:
                // if no lyrics then
                song.lyrics == null || song.lyrics == ''
                    ? Center(
                        child: Text(
                          'No Lyrics Found',
                          style: Theme.of(context).textTheme.bBM.copyWith(
                                color: AppColors().onSurface,
                                letterSpacing: 1,
                              ),
                        ),
                      )
                    : Text(
                        song.lyrics!,
                        style: Theme.of(context).textTheme.bBM.copyWith(
                              color: AppColors().onSurface,
                              letterSpacing: 1,
                            ),
                      ),
          ),
        );
      },
    );
  }
}

class LyricsViewBig extends StatelessWidget {
  const LyricsViewBig({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors().surfaceContainerHighest,
      ),
    );
  }
}

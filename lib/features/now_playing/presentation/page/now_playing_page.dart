import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/bottom_nav/presentation/widget/duration_slider.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_state.dart';
import 'package:musync/features/now_playing/presentation/widgets/audio_controllers.dart';
import 'package:musync/features/now_playing/presentation/widgets/lyrics_view.dart';
import 'package:musync/features/now_playing/presentation/widgets/more_controls.dart';
import 'package:musync/features/now_playing/presentation/widgets/queue_view.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  final scrollController = ScrollController();
  final GlobalKey queueTarget = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        if (state.currentSong == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                // Animated Navigation to new page
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_downward_rounded,
              ),
            ),
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'NOW PLAYING',
                  style: Theme.of(context).textTheme.lBM.copyWith(
                        color: AppColors().onBackground,
                      ),
                ),
                Text(
                  state.currentSong!.title,
                  style: Theme.of(context).textTheme.mBS.copyWith(
                        color: AppColors().onBackground,
                      ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  //? Album Cover
                  Hero(
                    tag: 'NowPlayingAlbumArt',
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 44.h,
                      ),
                      child: SongArtWork(
                        song: state.currentSong!,
                        height: 300.h,
                        width: MediaQuery.of(context).size.width,
                        borderRadius: 8.r,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8.h,
                  ),
                  //? Song Title
                  Text(
                    state.currentSong!.title,
                    style: Theme.of(context).textTheme.bBL.copyWith(
                          color: AppColors().onBackground,
                        ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  //? Artist Name
                  Text(
                    '${state.currentSong!.artist}',
                    style: Theme.of(context).textTheme.mBM.copyWith(
                          color: AppColors(inverseDarkMode: true).surfaceDim,
                        ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  // ? Duration Slider
                  DurationSlider(
                    audioPlayer: state.audioPlayer!,
                    height: 4.h,
                    thumbRadius: 8.r,
                    overlayRadius: 8.r,
                    duration: true,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  const AudioControllers(),
                  SizedBox(
                    height: 8.h,
                  ),
                  MoreControls(
                    setScroll: scrollToTarget,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  //? LyricsView
                  LyricsView(
                    song: state.currentSong!,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  //? QueueView
                  QueueView(
                    key: queueTarget,
                    songList: state.queue!,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void scrollToTarget() async {
    final context = queueTarget.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}

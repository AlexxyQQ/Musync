import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/bottom_nav/presentation/widget/duration_slider.dart';
import 'package:musync/features/home/domain/entity/song_entity.dart';
import 'package:musync/features/now_playing/presentation/cubit/now_playing_state.dart';
import 'package:musync/features/now_playing/presentation/widgets/audio_controllers.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
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
                onPressed: () {
                  // songOptions(song, context);
                },
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                //? Album Cover
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 44.h,
                  ),
                  child: SongArtWork(
                    song: state.currentSong!,
                    height: 350.h,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: 8.r,
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
              ],
            ),
          ),
        );
      },
    );
  }
}

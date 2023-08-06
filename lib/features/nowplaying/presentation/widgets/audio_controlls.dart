import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/features/nowplaying/presentation/state/now_playing_state.dart';
import 'package:musync/features/nowplaying/presentation/view_model/now_playing_view_model.dart';
import 'package:musync/features/nowplaying/presentation/widgets/share_window.dart';
import 'package:palette_generator/palette_generator.dart';

class AudioControlls extends StatefulWidget {
  const AudioControlls({
    super.key,
    this.iconSize = 40.0,
  });

  final double iconSize;

  @override
  State<AudioControlls> createState() => _AudioControllsState();
}

class _AudioControllsState extends State<AudioControlls> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingViewModel, NowPlayingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Shuffle Button
            IconButton(
              onPressed: () async {
                state.isShuffle
                    ? await context.read<NowPlayingViewModel>().shuffle()
                    : await context.read<NowPlayingViewModel>().unShuffle();
              },
              color: state.isShuffle //* if shuffle is on
                  ? KColors.accentColor
                  : MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? KColors.whiteColor
                      : KColors.blackColor,
              icon: Icon(
                Icons.shuffle_rounded,
                size: widget.iconSize,
              ),
            ),
            // Previous Button
            IconButton(
              onPressed: () async {
                await context.read<NowPlayingViewModel>().previous();
              },
              icon: Icon(
                Icons.skip_previous_rounded,
                size: widget.iconSize,
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? KColors.whiteColor
                        : KColors.blackColor,
              ),
            ),
            // Play/Pause Button
            CircleAvatar(
              radius: 35,
              backgroundColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? KColors.whiteColor
                      : KColors.blackColor,
              child: IconButton(
                onPressed: () async {
                  (state.isPaused || state.isStopped)
                      ? await context.read<NowPlayingViewModel>().play()
                      : await context.read<NowPlayingViewModel>().pause();
                },
                icon: Icon(
                  (state.isPaused || state.isStopped) //* if paused or stopped
                      ? Icons.play_arrow_rounded
                      : Icons.pause_rounded,
                  color: KColors.accentColor,
                  size: widget.iconSize,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await context.read<NowPlayingViewModel>().next();
              },
              icon: Icon(
                Icons.skip_next_rounded,
                size: widget.iconSize,
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? KColors.whiteColor
                        : KColors.blackColor,
              ),
            ),
            // Repeat Button
            IconButton(
              onPressed: () {
                if (!state.isRepeatOne && !state.isRepeatAll) {
                  context.read<NowPlayingViewModel>().repeatAll();
                } else if (state.isRepeatAll) {
                  context.read<NowPlayingViewModel>().repeatOne();
                } else if (state.isRepeatOne) {
                  context.read<NowPlayingViewModel>().repeatOff();
                }
              },
              icon: Icon(
                !state.isRepeatOne && !state.isRepeatAll
                    ? Icons.repeat_rounded
                    : state.isRepeatAll
                        ? Icons.repeat_rounded
                        : Icons.repeat_one_rounded,
                size: widget.iconSize,
                color: !state.isRepeatOne && !state.isRepeatAll
                    ? MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? KColors.whiteColor
                        : KColors.blackColor
                    : KColors.accentColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class MoreControlls extends StatelessWidget {
  final void Function() bottomSheetCallback;
  const MoreControlls({
    super.key,
    required this.bottomSheetCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: const Row(
              children: [
                Icon(
                  Icons.phone_android_rounded,
                  color: Colors.amber,
                  size: 24,
                ),
                SizedBox(width: 5),
                Text(
                  'Phone',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 19,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.share_rounded),
            iconSize: 24,
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? KColors.whiteColor
                : KColors.blackColor,
            onPressed: () async {
              // show share window
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const SharePage(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.queue_music_rounded),
            iconSize: 24,
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? KColors.whiteColor
                : KColors.blackColor,
            onPressed: () {
              bottomSheetCallback();
            },
          ),
        ],
      ),
    );
  }
}

class DurationSlider extends StatefulWidget {
  final double height;
  final bool duration;
  final Color activeColor;
  final Color inactiveColor;
  final double thumbRadius;
  final double overlayRadius;

  const DurationSlider({
    Key? key,
    required this.audioPlayer,
    required this.height,
    this.duration = true,
    required this.activeColor,
    required this.thumbRadius,
    required this.overlayRadius,
    required this.inactiveColor,
  }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  State<DurationSlider> createState() => _DurationSliderState();
}

class _DurationSliderState extends State<DurationSlider> {
  double _sliderValue = 0.0;
  double _maxValue = 1.0;
  late StreamSubscription<Duration?>? _durationSubscription;
  late StreamSubscription<Duration?>? _positionSubscription;

  @override
  void initState() {
    super.initState();
    _durationSubscription =
        widget.audioPlayer.durationStream.listen((duration) {
      setState(() {
        _maxValue = duration?.inSeconds.toDouble() ?? 1.0;
      });
    });

    _positionSubscription =
        widget.audioPlayer.positionStream.listen((position) {
      setState(() {
        _sliderValue = position.inSeconds.toDouble();
        if (position == widget.audioPlayer.duration) {
          context.read<NowPlayingViewModel>().next();
        }
      });
    });
  }

  @override
  void dispose() {
    try {
      _durationSubscription?.cancel();
      _positionSubscription?.cancel();
    } catch (e) {}

    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbColor: widget.activeColor,
            activeTrackColor: widget.activeColor,
            inactiveTrackColor: widget.inactiveColor,
            overlayColor: Colors.blue.withOpacity(0.2),
            trackHeight: widget.height,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: widget.thumbRadius,
            ),
            overlayShape: RoundSliderOverlayShape(
              overlayRadius: widget.overlayRadius,
            ),
          ),
          child: Slider(
            value: _sliderValue,
            min: 0,
            max: _maxValue,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
              final position = Duration(seconds: value.toInt());
              widget.audioPlayer.seek(position);
              widget.audioPlayer.play();
            },
          ),
        ),
        widget.duration
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(
                        Duration(
                          seconds: _sliderValue.toInt(),
                        ),
                      ),
                      style: TextStyle(
                        color: widget.activeColor,
                      ),
                    ),
                    Text(
                      _formatDuration(
                        Duration(
                          seconds: _maxValue.toInt(),
                        ),
                      ),
                      style: TextStyle(
                        color: widget.activeColor,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox()
      ],
    );
  }
}

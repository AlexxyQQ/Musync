import 'package:musync/core/common/exports.dart';

class DurationSlider extends StatefulWidget {
  final double height;
  final bool duration;
  final double thumbRadius;
  final double overlayRadius;

  const DurationSlider({
    Key? key,
    required this.audioPlayer,
    required this.height,
    this.duration = true,
    required this.thumbRadius,
    required this.overlayRadius,
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
          context.read<NowPlayingCubit>().next();
        }
      });
    });
  }

  // HI my miss piggy

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
            thumbColor: PrimitiveColors.primary500,
            activeTrackColor: PrimitiveColors.primary500,
            inactiveTrackColor: PrimitiveColors.primary900,
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
                        color: AppColors().onBackground,
                      ),
                    ),
                    Text(
                      _formatDuration(
                        Duration(
                          seconds: _maxValue.toInt(),
                        ),
                      ),
                      style: TextStyle(
                        color: AppColors().onBackground,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

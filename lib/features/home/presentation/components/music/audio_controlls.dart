// import 'dart:async';

// import 'package:flutter/material.dart';

// class AudioControlls extends StatelessWidget {
//   const AudioControlls({
//     super.key,
//     // required this.audioController,
//     required this.playing,
//     // required this.processingState,
//     this.iconSize = 40.0,
//   });

//   // final AudioPlayerController audioController;
//   final bool playing;
//   // final ProcessingState processingState;
//   final double iconSize;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         // Shuffle Button
//         IconButton(
//           onPressed: () {
//             //TODO: Shuffle
//           },
//           color: true //* if shuffle is on
//               ? accentColor
//               : MediaQuery.of(context).platformBrightness == Brightness.dark
//                   ? whiteColor
//                   : blackColor,
//           icon: Icon(
//             Icons.shuffle_rounded,
//             size: iconSize,
//           ),
//         ),
//         // Previous Button
//         IconButton(
//           onPressed: () {
//             // TODO Previous
//           },
//           icon: Icon(
//             Icons.skip_previous_rounded,
//             size: iconSize,
//             color: MediaQuery.of(context).platformBrightness == Brightness.dark
//                 ? whiteColor
//                 : blackColor,
//           ),
//         ),
//         // Play/Pause Button
//         if (playing)
//           CircleAvatar(
//             radius: 35,
//             backgroundColor:
//                 MediaQuery.of(context).platformBrightness == Brightness.dark
//                     ? whiteColor
//                     : blackColor,
//             child: IconButton(
//               onPressed: () {
//                 // TODO Pause
//               },
//               icon: Icon(
//                 Icons.play_arrow_rounded,
//                 color: accentColor,
//                 size: iconSize,
//               ),
//             ),
//           )
//         else if (true) // TODO: processingState != ProcessingState.completed
//           CircleAvatar(
//             radius: 35,
//             backgroundColor:
//                 MediaQuery.of(context).platformBrightness == Brightness.dark
//                     ? whiteColor
//                     : blackColor,
//             child: IconButton(
//               onPressed: () {
//                 // TODO Play
//               },
//               icon: Icon(
//                 Icons.pause,
//                 color: accentColor,
//                 size: iconSize,
//               ),
//             ),
//           )
//         else
//           CircleAvatar(
//             radius: 35,
//             backgroundColor:
//                 MediaQuery.of(context).platformBrightness == Brightness.dark
//                     ? whiteColor
//                     : blackColor,
//             child: IconButton(
//               onPressed: () {
//                 // TODO Pause
//               },
//               icon: Icon(
//                 Icons.play_arrow,
//                 color: accentColor,
//                 size: iconSize,
//               ),
//             ),
//           ),
//         // Next Button
//         IconButton(
//           onPressed: () {
//             // TODO Next
//           },
//           icon: Icon(
//             Icons.skip_next_rounded,
//             size: iconSize,
//             color: MediaQuery.of(context).platformBrightness == Brightness.dark
//                 ? whiteColor
//                 : blackColor,
//           ),
//         ),
//         // Repeat Button
//         IconButton(
//           onPressed: () {
//             // TODO Repeat Logic
//             // if (audioController.player.loopMode == LoopMode.off) {
//             //   audioController.player.setLoopMode(LoopMode.all);
//             // } else if (audioController.player.loopMode == LoopMode.all) {
//             //   audioController.player.setLoopMode(LoopMode.one);
//             // } else if (audioController.player.loopMode == LoopMode.one) {
//             //   audioController.player.setLoopMode(LoopMode.off);
//             // }
//           },
//           icon: Icon(
//             // audioController.player.loopMode == LoopMode.off
//             //     ? Icons.repeat_rounded
//             //     : audioController.player.loopMode == LoopMode.all
//             //         ? Icons.repeat_rounded
//             //         : Icons.repeat_one_rounded,
//             Icons.repeat_one_rounded,
//             size: iconSize,
//             color: //audioController.player.loopMode == LoopMode.off
//                 true
//                     ? MediaQuery.of(context).platformBrightness ==
//                             Brightness.dark
//                         ? whiteColor
//                         : blackColor
//                     : accentColor,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MoreControlls extends StatelessWidget {
//   final void Function() bottomSheetCallback;
//   const MoreControlls({
//     super.key,
//     required this.bottomSheetCallback,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () {},
//             child: Row(
//               children: const [
//                 Icon(
//                   Icons.phone_android_rounded,
//                   color: Colors.amber,
//                   size: 24,
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   'Phone',
//                   style: TextStyle(
//                     color: Colors.amber,
//                     fontSize: 19,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Spacer(),
//           IconButton(
//             icon: const Icon(Icons.share_rounded),
//             iconSize: 24,
//             color: MediaQuery.of(context).platformBrightness == Brightness.dark
//                 ? whiteColor
//                 : blackColor,
//             onPressed: () async {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.queue_music_rounded),
//             iconSize: 24,
//             color: MediaQuery.of(context).platformBrightness == Brightness.dark
//                 ? whiteColor
//                 : blackColor,
//             onPressed: () {
//               bottomSheetCallback();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DurationSlider extends StatefulWidget {
//   final double height;
//   final bool duration;
//   final Color activeColor;
//   final Color inactiveColor;
//   final double thumbRadius;
//   final double overlayRadius;

//   const DurationSlider({
//     Key? key,
//     // required this.audioPlayer,
//     required this.height,
//     this.duration = true,
//     required this.activeColor,
//     required this.thumbRadius,
//     required this.overlayRadius,
//     required this.inactiveColor,
//   }) : super(key: key);

//   // final AudioPlayerController audioPlayer;

//   @override
//   State<DurationSlider> createState() => _DurationSliderState();
// }

// class _DurationSliderState extends State<DurationSlider> {
//   double _sliderValue = 0.0;
//   double _maxValue = 1.0;
//   late StreamSubscription<Duration?>? _durationSubscription;
//   late StreamSubscription<Duration?>? _positionSubscription;

//   @override
//   void initState() {
//     super.initState();
//     // _durationSubscription =
//     //     widget.audioPlayer.player.durationStream.listen((duration) {
//     //   setState(() {
//     //     _maxValue = duration?.inSeconds.toDouble() ?? 1.0;
//     //   });
//     // });

//     // _positionSubscription =
//     //     widget.audioPlayer.player.positionStream.listen((position) {
//     //   setState(() {
//     //     _sliderValue = position.inSeconds.toDouble();
//     //   });
//     // });
//   }

//   @override
//   void dispose() {
//     try {
//       _durationSubscription?.cancel();
//       _positionSubscription?.cancel();
//     } catch (e) {}

//     super.dispose();
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         SliderTheme(
//           data: SliderTheme.of(context).copyWith(
//             thumbColor: widget.activeColor,
//             activeTrackColor: widget.activeColor,
//             inactiveTrackColor: widget.inactiveColor,
//             overlayColor: Colors.blue.withOpacity(0.2),
//             trackHeight: widget.height,
//             thumbShape: RoundSliderThumbShape(
//               enabledThumbRadius: widget.thumbRadius,
//             ),
//             overlayShape: RoundSliderOverlayShape(
//               overlayRadius: widget.overlayRadius,
//             ),
//           ),
//           child: Slider(
//             value: _sliderValue,
//             min: 0,
//             max: _maxValue,
//             onChanged: (value) {
//               setState(() {
//                 _sliderValue = value;
//               });
//               final position = Duration(seconds: value.toInt());
//               // widget.audioPlayer.player.seek(position);
//               // widget.audioPlayer.player.play();
//             },
//           ),
//         ),
//         widget.duration
//             ? Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       _formatDuration(
//                         Duration(
//                           seconds: _sliderValue.toInt(),
//                         ),
//                       ),
//                       style: TextStyle(
//                         color: widget.activeColor,
//                       ),
//                     ),
//                     Text(
//                       _formatDuration(
//                         Duration(
//                           seconds: _maxValue.toInt(),
//                         ),
//                       ),
//                       style: TextStyle(
//                         color: widget.activeColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : const SizedBox()
//       ],
//     );
//   }
// }

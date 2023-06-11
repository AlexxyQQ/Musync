// Queue View

import 'package:flutter/material.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueueView extends StatelessWidget {
  final List<SongModel> songList;
  const QueueView({super.key, required this.songList});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: isDark ? KColors.offBlackColor : KColors.offWhiteColor,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:musync/core/constants.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: KColors.offBlackColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Song Image
              Hero(
                tag: 'albumArt',
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: KColors.todoColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // Song Title
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Song Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Artist Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Share Button
              IconButton(
                icon: const Icon(Icons.share_rounded),
                color: Colors.white,
                onPressed: () {},
              ),
              // Next Button
              IconButton(
                icon: const Icon(Icons.skip_next_rounded),
                color: Colors.white,
                onPressed: () {},
              ),

              // Play/Pause Button
              IconButton(
                icon: const Icon(Icons.play_arrow_rounded),
                color: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
          // Progress Bar
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: LinearProgressIndicator(
              minHeight: 3,
              value: 0.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              backgroundColor: KColors.todoColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:musync/config/constants/global_constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppTertiaryColor.yellow,
        strokeWidth: 6,
        strokeCap: StrokeCap.round,
        semanticsValue: 'Loading...',
        semanticsLabel: 'Loading...',
      ),
    );
  }
}

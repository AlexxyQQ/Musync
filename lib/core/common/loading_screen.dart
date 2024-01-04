import 'package:musync/core/common/exports.dart';

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
        color: PrimitiveColors.primary500,
        strokeWidth: 6,
        strokeCap: StrokeCap.round,
        semanticsValue: 'Loading...',
        semanticsLabel: 'Loading...',
      ),
    );
  }
}

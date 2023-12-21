extension FormatDurationExtension on int? {
  String formatDuration() {
    if (this == null) {
      return '00:00';
    }

    final ms = this!;
    Duration duration = Duration(milliseconds: ms);
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

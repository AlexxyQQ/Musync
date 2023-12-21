/// Formats a duration in seconds to a string in "00:00" format.
///
/// This function takes a duration in seconds and converts it to a string
/// in the "00:00" format, where the first two digits represent minutes,
/// and the last two digits represent seconds. Leading zeros are added if needed.
///
/// [durationInSeconds]: The duration in seconds to be formatted.
///
/// Returns a string representation of the formatted duration in "00:00" format.
String formatDuration(int durationInSeconds) {
  final ms = durationInSeconds;
  Duration duration = Duration(milliseconds: ms);
  int minutes = duration.inMinutes;
  int seconds = duration.inSeconds.remainder(60);
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

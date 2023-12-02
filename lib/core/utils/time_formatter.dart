
class DateTimeFormatter {
  static String formatAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    Duration difference = DateTime.now().toLocal().difference(dateTime);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'Yesterday';
      } else {
        return '${difference.inDays}days ago';
      }
    } else if (difference.inHours > 0) {
      return '${difference.inHours}hrs ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}min ago';
    } else {
      return 'Just now';
    }
  }
}

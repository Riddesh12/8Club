
class DurationFormatter {
  static String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  static String formatDurationFromMillis(int milliseconds) {
    int seconds = milliseconds ~/ 1000;
    return formatDuration(seconds);
  }

  static String getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
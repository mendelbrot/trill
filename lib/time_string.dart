String secondsToTimeString(int timeInSeconds) {
  final sign = timeInSeconds < 0 ? "-" : "";
  final duration = Duration(seconds: timeInSeconds.abs());
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$sign$hours:$minutes:$seconds";
}

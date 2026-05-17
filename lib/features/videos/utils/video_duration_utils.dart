double parseDurationToSeconds(String? durationStr) {
  if (durationStr == null || durationStr.isEmpty) {
    return 0.0;
  }

  final parts = durationStr.split(':');
  if (parts.isEmpty) {
    return 0.0;
  }

  try {
    if (parts.length == 3) {
      final hours = double.parse(parts[0]);
      final minutes = double.parse(parts[1]);
      final seconds = double.parse(parts[2]);
      return (hours * 3600.0) + (minutes * 60.0) + seconds;
    } else if (parts.length == 2) {
      final minutes = double.parse(parts[0]);
      final seconds = double.parse(parts[1]);
      return (minutes * 60.0) + seconds;
    } else if (parts.length == 1) {
      return double.parse(parts[0]);
    }
  } catch (_) {
  }
  return 0.0;
}

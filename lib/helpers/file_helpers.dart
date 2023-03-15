import 'dart:math' as math;

class FileHelper {
  static String formatBytes(int bytes, {int decimals = 2}) {
    if (bytes < 1) return '0 Bytes';
    const k = 1024;
    final dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', "ZB", 'YB'];

    final i = (math.log(bytes) / math.log(k)).floor();
    // final index = i.floor();

    final value = bytes / math.pow(k, i);
    return '${value.toStringAsFixed(dm)} ${sizes[i]}';
  }
}

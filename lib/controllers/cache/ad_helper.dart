import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid || Platform.isWindows) {
      return 'ca-app-pub-2001413788003710/4895942256';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2001413788003710/4895942256';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

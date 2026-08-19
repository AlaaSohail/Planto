import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';
import 'package:plant_care/controllers/services/service_locator.dart';

import '../cache/cache_helper.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();

    if (!enabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static Future<bool> shouldUpdateLocation() async {
    final lastUpdate = getIt<CacheHelper>().getData(
      key: ApiKeys.lastLocationUpdate,
    );

    if (lastUpdate == null) {
      return true;
    }

    final now = DateTime.now().millisecondsSinceEpoch;

    final difference = now - lastUpdate;

    const sixHours = 6 * 60 * 60 * 1000;

    return difference > sixHours;
  }

  static Future<void> saveLocationUpdateTime() async {
    await getIt<CacheHelper>().saveData(
      key: ApiKeys.lastLocationUpdate,

      value: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

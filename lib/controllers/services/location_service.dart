import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';
import 'package:plant_care/controllers/services/service_locator.dart';

import '../cache/cache_helper.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    try {
      // 1. افحص الصلاحية أولاً
      var permission = await Geolocator.checkPermission();

      debugPrint('📍 Permission before: $permission');

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        debugPrint('📍 Permission after: $permission');
      }

      if (permission == LocationPermission.denied) {
        debugPrint('❌ Location permission denied');
        return null;
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('❌ Location permission denied forever');

        await Geolocator.openAppSettings();

        return null;
      }

      // 2. بعد الحصول على الصلاحية افحص GPS
      final enabled = await Geolocator.isLocationServiceEnabled();

      debugPrint('📍 Location service enabled: $enabled');

      if (!enabled) {
        debugPrint('❌ Location service is disabled');

        await Geolocator.openLocationSettings();

        return null;
      }

      // 3. اجلب الموقع
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      ).timeout(
        const Duration(seconds: 15),
      );

      debugPrint(
        '✅ Location: ${position.latitude}, ${position.longitude}',
      );

      return position;
    } catch (e, stackTrace) {
      debugPrint('❌ Location error: $e');
      debugPrint('$stackTrace');

      return null;
    }
  }
  static Future<bool> shouldUpdateLocation() async {
    final lastUpdate = getIt<CacheHelper>().getData(
      key: ApiKeys.lastLocationUpdate,
    );

    if (lastUpdate == null) {
      return true;
    }

    final now = DateTime.now().millisecondsSinceEpoch;

    final difference = now - (lastUpdate as int);

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
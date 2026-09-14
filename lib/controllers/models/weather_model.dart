import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class WeatherModel {
  final double temperature;
  final double humidity;
  final double windSpeed;
  final int weatherCode;
  final double rain;
  final double snow;

  WeatherModel({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.rain,
    required this.snow,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'];

    return WeatherModel(
      temperature: (current['temperature_2m'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toDouble(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      weatherCode: current['weather_code'] as int,
      rain: (current['rain'] as num).toDouble(),
      snow: (current['snowfall'] as num).toDouble(),
    );
  }

  String description(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (weatherCode) {
      case 0:
        return l10n.weatherClearSky;

      case 1:
        return l10n.weatherMainlyClear;

      case 2:
        return l10n.weatherMostlyClear;

      case 3:
        return l10n.weatherOvercast;

      case 45:
        return l10n.weatherFog;

      case 48:
        return l10n.weatherRimeFog;

      case 51:
        return l10n.weatherLightDrizzle;

      case 53:
        return l10n.weatherModerateDrizzle;

      case 55:
        return l10n.weatherDenseDrizzle;

      case 61:
        return l10n.weatherSlightRain;

      case 63:
        return l10n.weatherModerateRain;

      case 65:
        return l10n.weatherHeavyRain;

      case 71:
        return l10n.weatherLightSnow;

      case 73:
        return l10n.weatherModerateSnow;

      case 75:
        return l10n.weatherHeavySnow;

      case 77:
        return l10n.weatherSnowGrains;

      case 80:
        return l10n.weatherSlightShowers;

      case 81:
        return l10n.weatherModerateShowers;

      case 82:
        return l10n.weatherViolentShowers;

      case 95:
        return l10n.weatherThunderstorm;

      case 96:
      case 97:
      case 98:
      case 99:
        return l10n.weatherHail;

      default:
        return l10n.weatherUnknown;
    }
  }

  String get icon {
    switch (weatherCode) {
      case 0:
      case 1:
      case 2:
        return "assets/images/sun.png";

      case 3:
        return "assets/images/cloudy.png";

      case 45:
      case 48:
        return "assets/images/fog.png";

      case 51:
      case 53:
      case 55:
        return "assets/images/drizzle.png";

      case 61:
      case 63:
        return "assets/images/rain.png";

      case 65:
        return "assets/images/heavy-rain.png";

      case 71:
      case 73:
      case 75:
      case 77:
        return "assets/images/snow.png";

      case 80:
      case 81:
      case 82:
        return "assets/images/showers.png";

      case 95:
        return "assets/images/thunder.png";

      case 96:
      case 97:
      case 98:
      case 99:
        return "assets/images/hail.png";

      default:
        return "assets/images/weather.png";
    }
  }
}
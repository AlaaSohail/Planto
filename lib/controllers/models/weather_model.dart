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

  String get description {
    switch (weatherCode) {
      case 0:
        return "Clear Sky";

      case 1:
        return "Mainly Clear";
      case 2:
        return "Mostly Clear";
      case 3:
        return "Overcast";

      case 45:
        return "Fog";
      case 48:
        return "Depositing Rime Fog";

      case 51:
        return "Light Drizzle";
      case 53:
        return "Moderate Drizzle";
      case 55:
        return "Dense Drizzle";

      case 61:
        return "Slight Rain";
      case 63:
        return "Moderate Rain";
      case 65:
        return "Heavy Rain";

      case 71:
        return "Light Snow";
      case 73:
        return "Moderate Snow";
      case 75:
        return "Heavy Snow";

      case 77:
        return "Snow Grains";

      case 80:
        return "Slight Showers";
      case 81:
        return "Moderate Showers";
      case 82:
        return "Violent Showers";

      case 95:
        return "Thunderstorm";

      case 96:
      case 97:
      case 98:
      case 99:
        return "Hail";

      default:
        return "Unknown";
    }
  }

  String get icon {
    switch (weatherCode) {
      case 0:
        return "assets/images/sun.png";

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

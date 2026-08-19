import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../cache/cache_helper.dart';
import '../../core/api/api_consumer.dart';
import '../../models/weather_model.dart';
import '../../paths/ApiEndpoints.dart';
import '../../services/service_locator.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.api) : super(WeatherInitial());

  WeatherModel? weather;

  final ApiConsumer api;

  Future<void> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    emit(WeatherLoading());

    try {
      final response = await api.get(
        ApiEndpoints.weatherUrl,
        queryParameters: {
          ApiKeys.latitude: latitude,
          ApiKeys.longitude: longitude,

          WeatherApiKeys.current:
              "temperature_2m,"
              "relative_humidity_2m,"
              "weather_code,"
              "wind_speed_10m,"
              "rain,"
              "snowfall",

          WeatherApiKeys.wind_speed_unit: "ms",
          WeatherApiKeys.temperature_unit: "celsius",
        },
      );

      weather = WeatherModel.fromJson(response);

      emit(WeatherSuccess(weather!));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}

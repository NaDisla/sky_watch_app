import 'package:sky_watch_app/models/models.dart';

class Forecast {
  ForecastDetail forecast;

  Forecast({required this.forecast});

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecast: ForecastDetail.fromJson(json["forecast"]),
      );
}

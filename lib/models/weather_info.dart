import 'package:sky_watch_app/models/models.dart';

class WeatherInfo {
  Location location;
  Current current;

  WeatherInfo({
    required this.location,
    required this.current,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => WeatherInfo(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );
}

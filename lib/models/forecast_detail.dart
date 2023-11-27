import 'package:sky_watch_app/models/models.dart';

class ForecastDetail {
  List<ForecastDay> forecastday;

  ForecastDetail({required this.forecastday});

  factory ForecastDetail.fromJson(Map<String, dynamic> json) => ForecastDetail(
        forecastday:
            List<ForecastDay>.from(json["forecastday"].map((x) => ForecastDay.fromJson(x))),
      );
}

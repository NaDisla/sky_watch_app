import 'package:sky_watch_app/models/models.dart';

class Current {
  int? lastUpdatedEpoch;
  String? lastUpdated;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? windKph;
  int? windDegree;
  String? windDir;
  double? pressureMb;
  double? pressureIn;
  double? precipMm;
  double? precipIn;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? visKm;
  double? visMiles;
  double? uv;
  double? gustMph;
  double? gustKph;
  String? currentStrUpdatedDate;

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        lastUpdatedEpoch: json["last_updated_epoch"],
        lastUpdated: json["last_updated"],
        tempC: json["temp_c"],
        tempF: json["temp_f"],
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"],
        windKph: json["wind_kph"],
        windDegree: json["wind_degree"],
        windDir: json["wind_dir"],
        pressureMb: json["pressure_mb"],
        pressureIn: json["pressure_in"],
        precipMm: json["precip_mm"],
        precipIn: json["precip_in"],
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeC: json["feelslike_c"],
        feelslikeF: json["feelslike_f"],
        visKm: json["vis_km"],
        visMiles: json["vis_miles"],
        uv: json["uv"],
        gustMph: json["gust_mph"],
        gustKph: json["gust_kph"],
      );

// Map<String, dynamic> toJson() => {
//       "last_updated_epoch": lastUpdatedEpoch,
//       "last_updated": lastUpdated,
//       "temp_c": tempC,
//       "temp_f": tempF,
//       "is_day": isDay,
//       "condition": condition.toJson(),
//       "wind_mph": windMph,
//       "wind_kph": windKph,
//       "wind_degree": windDegree,
//       "wind_dir": windDir,
//       "pressure_mb": pressureMb,
//       "pressure_in": pressureIn,
//       "precip_mm": precipMm,
//       "precip_in": precipIn,
//       "humidity": humidity,
//       "cloud": cloud,
//       "feelslike_c": feelslikeC,
//       "feelslike_f": feelslikeF,
//       "vis_km": visKm,
//       "vis_miles": visMiles,
//       "uv": uv,
//       "gust_mph": gustMph,
//       "gust_kph": gustKph,
//     };
}

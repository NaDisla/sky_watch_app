import 'package:sky_watch_app/models/models.dart';

class ForecastDay {
  DateTime date;
  int dateEpoch;
  Day day;
  List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => ForecastDay(
        date: DateTime.parse(json["date"]),
        dateEpoch: json["date_epoch"],
        day: Day.fromJson(json["day"]),
        hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))),
      );
}

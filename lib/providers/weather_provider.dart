import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sky_watch_app/models/models.dart';

class WeatherProvider extends ChangeNotifier {
  final String _baseUrl = "api.weatherapi.com", _apiKey = "77eaaa3af8974432818165828231011";
  String error = "";
  Location currentLocation = Location();
  Current currentWeatherInfo = Current();
  List<ForecastDay> forecastDay = [];
  bool isLoading = true;
  static String weatherCondition = "";
  Map<int, String> days = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };
  Map<int, String> months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  WeatherProvider() {
    getWeatherInfo();
    getForecastInfo();
  }

  Future<String> _getJsonData(String endpoint, String query, String days) async {
    Uri url = Uri();
    if (days.isEmpty) {
      url = Uri.https(_baseUrl, endpoint, {'key': _apiKey, 'q': query});
    } else {
      url = Uri.https(_baseUrl, endpoint, {'key': _apiKey, 'q': query, 'days': days});
    }
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        error = response.statusCode.toString();
        return error;
      }
    } catch (e) {
      error = e.toString();
      return error;
    }
  }

  getWeatherInfo() async {
    final jsonResult = await _getJsonData("v1/current.json", "Santo Domingo", "");
    final weatherInfoResponse = WeatherInfo.fromJson(json.decode(jsonResult));
    currentLocation = weatherInfoResponse.location;
    currentWeatherInfo = weatherInfoResponse.current;
    weatherCondition = currentWeatherInfo.condition!.text;
    final locationDate = currentLocation.localtime!.split(" ");
    DateTime currentDate = DateTime.parse(locationDate[0]);
    currentLocation.currentStrDate =
        "${days[currentDate.weekday]}, ${months[currentDate.month]} ${currentDate.day} ${currentDate.year}";
    final updatedDate = currentWeatherInfo.lastUpdated!.split(" ");
    DateTime lastUpdatedDate = DateTime.parse(updatedDate[0]);
    final time = updatedDate[1].split(":");
    String dayTime = int.parse(time[0]) <= 11 ? "AM" : "PM";
    currentWeatherInfo.currentStrUpdatedDate =
        "${lastUpdatedDate.month}/${lastUpdatedDate.day}/${lastUpdatedDate.year} ${updatedDate[1]} $dayTime";
    isLoading = false;
    notifyListeners();
  }

  getForecastInfo() async {
    final jsonResult = await _getJsonData("v1/forecast.json", "Santo Domingo", "7");
    final forecastResponse = Forecast.fromJson(json.decode(jsonResult));
    forecastDay = forecastResponse.forecast.forecastday;
    notifyListeners();
  }
}

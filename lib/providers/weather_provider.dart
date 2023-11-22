import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sky_watch_app/models/models.dart';

class WeatherProvider extends ChangeNotifier {
  final String _baseUrl = "api.weatherapi.com", _apiKey = "77eaaa3af8974432818165828231011";
  String error = "";
  Location currentLocation = Location();
  Current currentWeatherInfo = Current();
  bool isLoading = true;

  WeatherProvider() {
    getWeatherInfo();
  }

  Future<String> _getJsonData(String endpoint, String query) async {
    final url = Uri.https(_baseUrl, endpoint, {'key': _apiKey, 'q': query});
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
    final jsonResult = await _getJsonData("v1/current.json", "Santo Domingo");
    final weatherInfoResponse = WeatherInfo.fromJson(json.decode(jsonResult));
    currentLocation = weatherInfoResponse.location!;
    currentWeatherInfo = weatherInfoResponse.current!;
    isLoading = false;
    notifyListeners();
  }
}

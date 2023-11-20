import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sky_watch_app/models/models.dart';

class WeatherProvider extends ChangeNotifier {
  final String _baseUrl = "api.weatherapi.com",
      _apiKey = "77eaaa3af8974432818165828231011";
  WeatherInfo weatherInfo = WeatherInfo();

  WeatherProvider() {
    getWeatherInfo();
  }

  Future<String> _getJsonData(String endpoint, String query) async {
    final url = Uri.https(
      _baseUrl,
      endpoint,
      {
        'key': _apiKey,
        'q': query,
      },
    );
    final response = await http.get(url);
    return response.body;
  }

  getWeatherInfo() async {
    final jsonResult = await _getJsonData("v1/current.json", "Santo Domingo");
    final weatherInfoResponse = WeatherInfo.fromJson(json.decode(jsonResult));
    weatherInfo = weatherInfoResponse;
    notifyListeners();
  }
}

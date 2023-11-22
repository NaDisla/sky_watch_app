import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sky_watch_app/models/models.dart';
import 'package:sky_watch_app/providers/providers.dart';

class BackgroundImageProvider extends ChangeNotifier {
  final String _baseUrl = "api.pexels.com",
      _apiKey = "3hSrgXI6zgj8AK16zk4vw3mpvZP1BMuY9TvPLPZeKMUeChWnDwKb8S7u";
  String error = "";
  BackgroundImage backgroundImage = BackgroundImage();
  bool isLoading = true;

  BackgroundImageProvider() {
    getBackgroundImage();
  }

  Future<String> _getJsonData(String endpoint, String query) async {
    final url = Uri.https(_baseUrl, endpoint, {'query': query, 'per_page': '10'});
    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: _apiKey},
      );
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

  getBackgroundImage() async {
    final jsonResult = await _getJsonData("v1/search", "${WeatherProvider.weatherCondition} sky");
    final backgroundImageResponse = BackgroundImage.fromJson(json.decode(jsonResult));
    backgroundImage = backgroundImageResponse;
    isLoading = false;
    notifyListeners();
  }
}

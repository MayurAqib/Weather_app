import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherConditionApi {
  Future<Object> getCurrentWeather(String? location) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=369f10c5086a1d545636fbf26dbe7f38&units=metric'));
      var body = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 250) {
        return WeatherModel.fromJson(body);
      }
      if (response.statusCode >= 400 && response.statusCode < 500) {
        return const Text('Client Error Responses');
      }
      if (response.statusCode >= 500 && response.statusCode < 600) {
        return const Text('Server Error Responses');
      }
    } catch (e) {
      debugPrint('Weather Condition API error: $e ');
    }
    return const Text('Problem occured\nTry again after sometime');
  }
}

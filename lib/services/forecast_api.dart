import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/forecast_model.dart';

class ForeCastApi {
  Future<List<ForeCastModel>> fetchForeCastData(String location) async {
    try {
      String forecastUrl =
          'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=369f10c5086a1d545636fbf26dbe7f38';
      var response = await http.get(Uri.parse(forecastUrl));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var cityData = jsonData['city']; // Extract the 'city' field

        List<ForeCastModel> foreCastDataListApi = [];
        Map<DateTime, ForeCastModel> dailyData = {};

        for (var item in jsonData['list']) {
          var dateTime = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
          var dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
          var dayName = DateFormat.EEEE().format(dateOnly);
          var main = item['main'];
          var weather = item['weather'][0];

          double temp = main['temp'] - 273.15;
          int humidity = main['humidity'];

          if (!dailyData.containsKey(dateOnly)) {
            dailyData[dateOnly] = ForeCastModel(
              date: dayName,
              tempMin: temp,
              tempMax: temp,
              humidity: humidity,
              icon: weather['icon'],
              cityName: cityData?['name'],
              weatherDescription: weather['description'],
            );
          } else {
            if (temp < double.parse(dailyData[dateOnly]!.tempMin.toString())) {
              dailyData[dateOnly]!.tempMin = temp;
            }
            if (temp > double.parse(dailyData[dateOnly]!.tempMax.toString())) {
              dailyData[dateOnly]!.tempMax = temp;
            }
          }
        }
        // Modify the first day's temperature to use the minimum and maximum of the entire day
        var firstDay = dailyData.keys.first;
        var firstDayData = dailyData[firstDay];
        var minTemp = double.parse(firstDayData!.tempMin.toString());
        var maxTemp = double.parse(firstDayData.tempMax.toString());
        for (var forecast in dailyData.values) {
          minTemp = min(minTemp, double.parse(forecast.tempMin.toString()));
          maxTemp = max(maxTemp, double.parse(forecast.tempMax.toString()));
        }
        firstDayData.tempMin = minTemp;
        firstDayData.tempMax = maxTemp;
        var sortedKeys = dailyData.keys.toList()..sort();
        var sortedData = {for (var t in sortedKeys) t: dailyData[t]};

        sortedData.forEach((_, forecast) {
          foreCastDataListApi.add(forecast!);
        });

        return foreCastDataListApi;
      }
      if (response.statusCode >= 300 && response.statusCode < 400) {
        throw Exception('client error');
      }
      if (response.statusCode >= 400 && response.statusCode < 500) {
        throw Exception('server error');
      }
    } catch (e) {
      debugPrint('forecast api error: $e');
    }

    throw Exception('API call failed');
  }
}

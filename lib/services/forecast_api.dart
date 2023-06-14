// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/forecast_5day_model.dart';

class ForeCastApi {
  Future<List<ForeCastModel>> fetchForeCastData(String location) async {
    try {
      String apiUrl =
          'https://api.openweathermap.org/data/2.5/forecast?q=$location&cnt=&appid=369f10c5086a1d545636fbf26dbe7f38&units=metric';
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var cityData = jsonData['city']; // Extract the 'city' field
        print(cityData);

        List<ForeCastModel> foreCastDataListApi = [];

        Map<DateTime, List<Map<String, dynamic>>> groupedData = {};

        for (var item in jsonData['list']) {
          var dateTime = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
          var dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
          if (!groupedData.containsKey(dateOnly)) {
            groupedData[dateOnly] = [];
          }
          groupedData[dateOnly]!.add(item);
        }

        groupedData.forEach((date, itemList) {
          double minTemp = double.infinity;
          double maxTemp = double.negativeInfinity;
          int humiditySum = 0;
          String? icon;
          String? weatherDescription;
          String? dayName = DateFormat.EEEE().format(date);

          for (var item in itemList) {
            var main = item['main'];
            var weather = item['weather'][0];

            double temp = main['temp'];
            if (temp < minTemp) {
              minTemp = temp;
            }
            if (temp > maxTemp) {
              maxTemp = temp;
            }

            humiditySum += int.parse(main['humidity'].toString());

            if (icon == null) {
              icon = weather['icon'];
              weatherDescription = weather['description'];
            }
          }

          int humidityAvg = humiditySum ~/ itemList.length;

          foreCastDataListApi.add(ForeCastModel(
            date: dayName,
            tempMin: double.parse(minTemp.toStringAsFixed(2)),
            tempMax: double.parse(maxTemp.toStringAsFixed(2)),
            humidity: humidityAvg,
            icon: icon,
            cityName: cityData?['name'],
            weatherDescription: weatherDescription,
          ));
        });

        return foreCastDataListApi;
      }
    } catch (e) {
      debugPrint('forecast api error: $e');
    }

    throw Exception('API call failed');
  }
}

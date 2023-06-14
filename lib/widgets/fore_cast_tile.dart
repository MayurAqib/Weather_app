import 'package:flutter/material.dart';
import 'package:weather_app_using_rest_api/theme/colors.dart';

class ForeCastTile extends StatelessWidget {
  const ForeCastTile(
      {super.key,
      required this.humidity,
      required this.imageUrl,
      required this.tempMax,
      required this.tempMin,
      required this.date,
      required this.weatherDescription});
  final String imageUrl;
  final String tempMax;
  final String tempMin;
  final String humidity;
  final String date;
  final String weatherDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: designColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date),
              Row(
                children: [
                  Text('$humidity %'),
                  Image.network(
                    'http://openweathermap.org/img/wn/$imageUrl.png',
                    height: 55,
                  ),
                ],
              ),
              Text('$tempMax\u2103  $tempMin\u2103')
            ],
          ),
          Text(
            weatherDescription,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

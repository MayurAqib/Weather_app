import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';
import 'details_row.dart';
import 'my_textfield.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather(
      {super.key,
      required this.condition,
      required this.controller,
      required this.feelsLike,
      required this.humidity,
      required this.iconUrl,
      required this.name,
      required this.onTap,
      required this.pressure,
      required this.temp,
      required this.wind});
  final TextEditingController controller;
  final void Function() onTap;
  final double? temp;
  final String? condition;
  final String? name;
  final int? humidity;
  final double? feelsLike;
  final int? pressure;
  final double? wind;
  final String? iconUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //todo: Heading
        Text(
          'W E A T H E R ',
          style: GoogleFonts.bebasNeue(fontSize: 50),
        ),
        const SizedBox(
          height: 10,
        ),
        //todo: Search for any city Text
        Text(
          'Search weather conditons for any city',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
        const SizedBox(
          height: 10,
        ),
        //todo: Row of textfield and a button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //todo: textfield
              MyTextfield(controller: controller),
              const SizedBox(
                width: 8,
              ),
              //todo: Button
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      color: designColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Search',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

        //todo: row of temp ,icon, time and condition

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //todo:  temperture and time column
              Text(
                '$temp \u2103',
                style:
                    const TextStyle(fontSize: 58, fontWeight: FontWeight.bold),
              ),
              //todo:  icon and condition column

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    child: Image.network(
                      'http://openweathermap.org/img/wn/$iconUrl.png',
                      fit: BoxFit.fill,
                      color: designColor,
                    ),
                  ),
                  //todo: Weather Update
                  Text(
                    '$condition',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),

        //todo: cityName
        Text(
          '$name',
          style: const TextStyle(
              fontSize: 25, color: designColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        //todo: Weather details
        const Text(
          'Weather Conditions',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        DetailRow(heading: 'Humidity', weatherDetails: humidity.toString()),
        const SizedBox(
          height: 20,
        ),
        DetailRow(heading: 'feels_like', weatherDetails: '$feelsLike \u2103'),
        const SizedBox(
          height: 20,
        ),
        DetailRow(heading: 'pressure ', weatherDetails: pressure.toString()),
        const SizedBox(
          height: 20,
        ),
        DetailRow(heading: 'Wind ', weatherDetails: wind.toString()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 90),
          child: Divider(
            color: textColor,
          ),
        ),
      ],
    );
  }
}

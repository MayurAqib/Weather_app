import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_using_rest_api/pages/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              elevation: 0,
              color: Colors.transparent,
              centerTitle: true,
              titleTextStyle: GoogleFonts.bebasNeue(
                fontSize: 40,
              )),
          textTheme: TextTheme(
              bodyMedium: GoogleFonts.montserrat(color: Colors.white))),
      home: const WeatherConditions(),
    );
  }
}

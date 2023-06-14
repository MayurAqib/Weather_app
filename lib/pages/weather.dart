import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app_using_rest_api/services/weather_conditions_api.dart';
import 'package:weather_app_using_rest_api/theme/colors.dart';
import 'package:weather_app_using_rest_api/widgets/current_weather_data.dart';
import 'package:weather_app_using_rest_api/widgets/fore_cast_tile.dart';
import '../models/forecast_model.dart';
import '../models/weather_model.dart';
import '../services/forecast_api.dart';

class WeatherConditions extends StatefulWidget {
  const WeatherConditions({super.key});
  @override
  State<WeatherConditions> createState() => _WeatherConditionsState();
}

class _WeatherConditionsState extends State<WeatherConditions> {
  final searchController = TextEditingController(); //! Controller

  WeatherModel? weatherData;
  List<ForeCastModel> foreCastDataList = [];
  String? cityName = 'Mohali';

  WeatherConditionApi client = WeatherConditionApi();
  final StreamController<WeatherModel?> _streamController =
      StreamController<WeatherModel?>();

  //! fetching current weather data from api
  void getWeatherData() async {
    try {
      WeatherModel? weatherData =
          (await client.getCurrentWeather(cityName!)) as WeatherModel?;
      _streamController.add(weatherData);
    } catch (e) {
      debugPrint(e.toString());
      showDialog(
          context: context,
          builder: (context) {
            // Create a GlobalKey to access the dialog later
            final dialogKey = GlobalKey<State>();

            Timer(const Duration(seconds: 1), () {
              if (dialogKey.currentContext != null) {
                Navigator.of(context).pop();
              }
            });
            return AlertDialog(
              key: dialogKey,
              backgroundColor: designColor,
              title: const Text('Search a valid city name'),
            );
          });
    }
  }

  ForeCastApi weatherAPI = ForeCastApi();
  //! fetching forecast data function
  Stream<List<ForeCastModel>> getForeCastData(String cityName) async* {
    try {
      while (true) {
        List<ForeCastModel> forecastData =
            await weatherAPI.fetchForeCastData(cityName);
        yield forecastData;
        await Future.delayed(
            const Duration(minutes: 15)); // Update every 15 minutes
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
    getForeCastData(cityName!);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<WeatherModel?>(
                    stream: _streamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        WeatherModel? weatherData = snapshot.data;
                        return CurrentWeather(
                            condition: weatherData?.condition,
                            controller: searchController,
                            feelsLike: weatherData?.feelsLike,
                            humidity: weatherData?.humidity,
                            iconUrl: weatherData?.iconUrl,
                            name: weatherData?.name,
                            onTap: () {
                              setState(() {
                                cityName = searchController.text.trim();
                              });
                              getWeatherData();
                            },
                            pressure: weatherData?.pressure,
                            temp: weatherData?.temp,
                            wind: weatherData?.wind);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.orange,
                        ));
                      } else {
                        return const Center(child: Text('No Data Fetched'));
                      }
                    },
                  ),

                  //todo: Forecast Data
                  StreamBuilder<List<ForeCastModel>>(
                    stream: getForeCastData(cityName!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ForeCastModel> forecastData = snapshot.data!;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 560,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: forecastData.length,
                            itemBuilder: (context, index) {
                              ForeCastModel forecast = forecastData[index];
                              return ForeCastTile(
                                weatherDescription:
                                    forecast.weatherDescription.toString(),
                                date: forecast.date.toString(),
                                humidity: forecast.humidity.toString(),
                                imageUrl: forecast.icon.toString(),
                                tempMax: forecast.tempMax!.toStringAsFixed(2),
                                tempMin: forecast.tempMin!.toStringAsFixed(2),
                              );
                            },
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.transparent,
                        ));
                      }
                      return const Text('No data fetched');
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

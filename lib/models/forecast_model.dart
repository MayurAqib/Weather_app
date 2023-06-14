class ForeCastModel {
  String? date;

  double? tempMin;
  double? tempMax;
  int? humidity;
  String? icon;
  String? cityName;
  String? weatherDescription;

  ForeCastModel({
    this.date,
    this.tempMin,
    this.tempMax,
    this.humidity,
    this.icon,
    this.cityName,
    this.weatherDescription,
  });

  factory ForeCastModel.fromJson(Map<String, dynamic> json,
      [Map<String, dynamic>? cityData]) {
    return ForeCastModel(
      date: json['dt_txt'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      humidity: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
      cityName: cityData?['name'],
      weatherDescription: json['weather'][0]['description'],
    );
  }
  @override
  String toString() {
    return 'ForeCastModel(date: $date, tempMin: $tempMin, tempMax: $tempMax, humidity: $humidity, icon: $icon, cityName: $cityName, weatherDescription: $weatherDescription)';
  }
}

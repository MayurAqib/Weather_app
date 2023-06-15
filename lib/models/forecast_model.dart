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
}

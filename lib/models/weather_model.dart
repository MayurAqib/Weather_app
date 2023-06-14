class WeatherModel {
  String? name;
  double? temp;
  double? wind;
  int? humidity;
  double? feelsLike;
  int? pressure;
  String? iconUrl;
  String? condition;

  WeatherModel({
    this.name,
    this.feelsLike,
    this.humidity,
    this.pressure,
    this.temp,
    this.wind,
    this.iconUrl,
    this.condition,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    feelsLike = json['main']['feels_like'];
    humidity = json['main']['humidity'];
    pressure = json['main']['pressure'];
    temp = json['main']['temp'];
    wind = json['wind']['speed'];
    iconUrl = json['weather'][0]['icon'];
    condition = json['weather'][0]['main'];
  }
}

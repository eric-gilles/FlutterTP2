class Weather {
  final String icon;
  final String description;
  final double temp;
  final double feelsLike;
  final double humidity;
  final double wind;
  final String pressure;
  final DateTime date;

  Weather({
    required this.icon,
    required this.description,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.wind,
    required this.pressure,
    required this.date,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      icon: json['weather'][0]['icon'] as String,
      description: json['weather'][0]['description'] as String,
      temp: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toDouble(),
      wind: (json['wind']['speed'] as num).toDouble(),
      pressure: json['main']['pressure'].toString(),
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
  // String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}
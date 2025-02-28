import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/data/models/weather.dart';

/// DataService class to fetch weather data from the OpenWeatherMap API
class DataService {
  String apiKey = dotenv.env['API_KEY'] ?? '';
  String apiURL = "https://api.openweathermap.org/data/2.5/";
  String langFR = "fr_FR";

  /// Fetch city weather data from the API
  Future<City> getCityFromAPI(String cityName) async {
    var url = Uri.parse('$apiURL/weather?q=$cityName&appid=$apiKey');
    var response = await http.get(url);
    _checkResponse(response);

    var result = jsonDecode(response.body);
    return City.fromJson(result);
  }

  /// Fetch weather data from the API by city
  Future<Weather> getWeatherFromAPI(City city, BuildContext context) async {
    return getWeatherFromAPIByCoordinates(context, city.latitude, city.longitude);
  }

  /// Fetch weather data from the API by coordinates
  Future<Weather> getWeatherFromAPIByCoordinates(BuildContext context, String latitude, String longitude) async {
    var lang = Localizations.localeOf(context).toString() == langFR ? 'fr' : 'en';
    var url = Uri.parse('$apiURL/weather?lat=$latitude&lon=$longitude&units=metric&lang=$lang&appid=$apiKey');
    var response = await http.get(url);
    _checkResponse(response);

    var result = jsonDecode(response.body);
    return Weather.fromJson(result);
  }

  /// Fetch weather forecast data from the API by city
  Future<List<Weather>> getWeatherForecastFromAPI(City city, BuildContext context) async {
    var lang = Localizations.localeOf(context).toString() == langFR ? 'fr' : 'en';
    var url = Uri.parse('$apiURL/forecast?lat=${city.latitude}&lon=${city.longitude}&units=metric&lang=$lang&appid=$apiKey');
    var response = await http.get(url);
    _checkResponse(response);

    final result = jsonDecode(response.body);
    final List<Weather> forecast = [];

    // Get the list of weather forecasts and convert them to a Weather List
    for (var item in result['list']) {
      forecast.add(Weather.fromJson(item));
    }
    return forecast;
  }

  /// Get Forecast data for the next 5 days
  /// It needs to have one Weather object per day at 12:00 PM (noon)
  /// Today's weather must not be included
  Future<List<Weather>> getWeatherForecastByDay(City city, BuildContext context) async {
    var forecast = await getWeatherForecastFromAPI(city, context);
    var today = DateTime.now().day;
    var forecastByDay = <Weather>[];

    // Group forecasts by day
    var dailyForecasts = <int, List<Weather>>{};
    for (var weather in forecast) {
      var day = weather.date.day;
      if (day != today) {
        dailyForecasts.putIfAbsent(day, () => []).add(weather);
      }
    }

    // Select the forecast closest to 12:00 PM (noon) for each day to display a day forecast
    for (var day in dailyForecasts.keys) {
      var closestToNoon = dailyForecasts[day]!.reduce((a, b) {
        var targetTime = DateTime(a.date.year, a.date.month, a.date.day, 12, 0);
        var aDiff = (a.date.difference(targetTime)).abs();
        var bDiff = (b.date.difference(targetTime)).abs();
        return aDiff < bDiff ? a : b;
      });
      forecastByDay.add(closestToNoon);
    }

    return forecastByDay;
  }

  /// Check the response status code and throw an exception if necessary
  void _checkResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return;
      case 400:
        throw Exception('Requête invalide! Veuillez réessayer.');  
      case 404:
        throw Exception('Ville non trouvée! Veuillez réessayer.');
      case 401:
        throw Exception('Clé API invalide! Veuillez vérifier votre fichier .env.');
      case 429:
        throw Exception('Limite de requêtes atteinte! Veuillez réessayer plus tard.');
      case 500:
        throw Exception('Erreur interne du serveur! Veuillez réessayer.');
      default:
        throw Exception('Erreur lors de la récupération de la météo! Veuillez réessayer.');
    }
  }
}
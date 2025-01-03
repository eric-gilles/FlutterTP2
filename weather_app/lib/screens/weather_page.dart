import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/theme_manager.dart';
import 'package:weather_app/screens/weather_details.dart';
import 'package:weather_app/screens/weather_forecast.dart';
import 'package:weather_app/service/data_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  final DataService _weatherService = DataService();
  City? _city;
  Weather? _weather;
  List<Weather> _forecast = [];
  bool _isLoading = false;

  void _fetchWeather() async {
    setState(() => _isLoading = true);
    try {
      final city = await _weatherService.getCityFromAPI(_controller.text.trim());
      final weather = await _weatherService.getWeatherFromAPI(city);
      final forecast = await _weatherService.getWeatherForecastByDay(city);
      setState(() {
        _city = city;
        _weather = weather;
        _forecast = forecast;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur: ${e.toString()}'),
      ));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Météo'),
        actions: [
          IconButton(
            icon: Icon(themeManager.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () {
              themeManager.toggleTheme();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Thème: ${themeManager.themeMode == ThemeMode.dark ? 'Sombre' : 'Clair'}',
                ),
              ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Entrez une ville',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _fetchWeather();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => _controller.clear(),
                      ),
                    ],
                  ),
                ),
                onSubmitted: (_) => _fetchWeather(),
              ),
              SizedBox(height: 16),
              if (_city != null && _weather != null)
                WeatherDetails(city: _city!, weather: _weather!),
              SizedBox(height: 10),
              if (_isLoading) CircularProgressIndicator(),
              if (_city != null && _forecast.isNotEmpty)
                Text('Prévisions pour les prochains jours', style: TextStyle(fontSize: 16)),
                WeatherForecast(forecast: _forecast),
            ],
          ),
        ),
      ),
    );
  }
}

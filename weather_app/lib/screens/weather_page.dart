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

class _WeatherPageState extends State<WeatherPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final DataService _weatherService = DataService();
  City? _city;
  Weather? _weather;
  List<Weather> _forecast = [];
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimationWeatherDetails;
  late AnimationController _forecastAnimationController;
  late Animation<Offset> _slideAnimationWeatherForecast;

  @override
  void initState() {
    super.initState();

    // Animation pour le WeatherDetails
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _slideAnimationWeatherDetails = Tween<Offset>(
      begin: Offset(0, 1), // Commence en bas de l'écran
      end: Offset.zero, // Se termine à la position d'origine
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Animation pour le WeatherForecast
    _forecastAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _slideAnimationWeatherForecast = Tween<Offset>(
      begin: Offset(0, 1), // Commence en bas de l'écran
      end: Offset.zero, // Se termine à la position d'origine
    ).animate(CurvedAnimation(
      parent: _forecastAnimationController,
      curve: Curves.easeOut,
    ));
  }

  void _fetchWeather() async {
    setState(() => _isLoading = true);
    try {
      final city = await _weatherService.getCityFromAPI(_controller.text.trim());
      final weather = await _weatherService.getWeatherFromAPI(city, context);
      final forecast = await _weatherService.getWeatherForecastByDay(city, context);
      setState(() {
        _city = city;
        _weather = weather;
        _forecast = forecast;
      });

      // Lancer l'animation WeatherDetails
      _animationController.forward();
      // Lancer l'animation WeatherForecast
      _forecastAnimationController.forward();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getErrorMessage(context, e.toString()))),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _forecastAnimationController.dispose();
    super.dispose();
  }

  // Méthodes de traduction des textes
  String _getAppBarTitle(BuildContext context) {
    return Localizations.localeOf(context).toString().startsWith('fr')
        ? 'Météo'
        : 'Weather';
  }

  String _getLabelText(BuildContext context) {
    return Localizations.localeOf(context).toString().startsWith('fr')
        ? 'Entrez une ville'
        : 'Enter a city';
  }

  String _getForecastText(BuildContext context) {
    return Localizations.localeOf(context).toString().startsWith('fr')
        ? 'Prévisions pour les prochains jours'
        : 'Forecast for the coming days';
  }

  String _getErrorMessage(BuildContext context, String error) {
    return Localizations.localeOf(context).toString().startsWith('fr')
        ? 'Erreur : $error'
        : 'Error: $error';
  }

  String _getThemeChangeMessage(BuildContext context, bool isDarkMode) {
    if (Localizations.localeOf(context).toString().startsWith('fr')) {
      return 'Thème: ${isDarkMode ? 'Sombre' : 'Clair'}';
    } else {
      return 'Theme: ${isDarkMode ? 'Dark' : 'Light'}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(context)),
        actions: [
          IconButton(
            icon: Icon(themeManager.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () {
              themeManager.toggleTheme();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_getThemeChangeMessage(
                    context,
                    themeManager.themeMode == ThemeMode.dark,
                  )),
                ),
              );
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
                  labelText: _getLabelText(context),
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
                SlideTransition(
                  position: _slideAnimationWeatherDetails,
                  child: WeatherDetails(key: ValueKey(_city), city: _city!, weather: _weather!),
                ),
              SizedBox(height: 10),
              if (_isLoading)
                Center(
                  child: AnimatedOpacity(
                    opacity: _isLoading ? 1.0 : 0.0,
                    duration: Duration(seconds: 2),
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (_city != null && _forecast.isNotEmpty)
                SlideTransition(
                  position: _slideAnimationWeatherForecast,
                  child: Column(
                    children: [
                      Text(
                        _getForecastText(context),
                        style: TextStyle(fontSize: 16),
                      ),
                      WeatherForecast(forecast: _forecast),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
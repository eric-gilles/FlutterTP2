import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/service/utils_service.dart';

class WeatherForecast extends StatelessWidget {
  final List<Weather> forecast;

  const WeatherForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final weatherF = forecast[index];
          return _buildForecastCard(weatherF, context);
        },
      ),
    );
  }

  Widget _buildForecastCard(Weather weatherF, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Jour
            Text(
              UtilsService.setFirstLetterToUpperCase(
                UtilsService.getLocalizedDayName(weatherF.date, context),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),

            // Icône météo et température
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getIcon(weatherF),
                const SizedBox(width: 8),
                Text(
                  '${weatherF.temp.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Description
            Text(
              UtilsService.setFirstLetterToUpperCase(weatherF.description),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),

            // Humidité
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.droplet,
                  color: Colors.blue,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text('Humidité: ${weatherF.humidity}%'),
              ],
            ),
            const SizedBox(height: 8),

            // Vent
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.wind,
                  color: Colors.blue,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text('Vent: ${(weatherF.wind * 3.6).toStringAsFixed(2)} km/h'),
              ],
            ),
            const SizedBox(height: 8),

            // Ressenti
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.temperatureFull,
                  color: Colors.blue,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text('Ressenti: ${weatherF.feelsLike.toStringAsFixed(1)}°C'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Méthode pour obtenir l'icône météo
  Widget getIcon(Weather weather) {
    if (!['01d', '01n'].contains(weather.icon.toString())) {
      return Image.network(
        weather.iconUrl,
        width: 50,
        height: 50,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.cloud_off,
          size: 50,
          color: Colors.grey[400],
        ),
      );
    } else {
      var icon = weather.icon == "01d"
          ? FontAwesomeIcons.solidSun
          : FontAwesomeIcons.solidMoon;
      return Icon(
        icon,
        size: 50,
        color: Colors.yellow[700],
      );
    }
  }
}

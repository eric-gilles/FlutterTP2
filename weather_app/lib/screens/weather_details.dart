import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/service/utils_service.dart';

class WeatherDetails extends StatelessWidget {
  final City city;
  final Weather weather;

  const WeatherDetails({super.key, required this.city, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 16, right: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // City Name
            Text(
              city.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // Date and Time
            SizedBox(height: 8),
            Text(
              '${UtilsService.setFirstLetterToUpperCase(UtilsService.getLocalizedDayName(DateTime.now(), context))} '
                  '${DateFormat('dd MMMM yyyy HH:mm', 'fr_FR').format(DateTime.now())}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            // Weather Icon
            SizedBox(height: 16),
            getIcon(weather),

            // Temperature and Weather Description
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${weather.temp.toStringAsFixed(1)}°C',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Text(
                  UtilsService.setFirstLetterToUpperCase(weather.description),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            Divider(height: 25, thickness: 1, color: Colors.grey[300]),

            // Humidity and Wind Speed and FeelsLike
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Humidity
                Column(
                  children: [
                    Icon(FontAwesomeIcons.droplet, color: Colors.blue),
                    SizedBox(height: 4),
                    Text(
                      'Humidité',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    Text(
                      '${weather.humidity}%',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                // Wind Speed
                Column(
                  children: [
                    Icon(FontAwesomeIcons.wind, color: Colors.blue),
                    SizedBox(height: 4),
                    Text(
                      'Vent',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    Text(
                      '${(weather.wind * 3.6).toStringAsFixed(2)} km/h',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                // FeelsLike
                Column(
                  children: [
                    Icon(FontAwesomeIcons.temperatureFull, color: Colors.blue),
                    SizedBox(height: 4),
                    Text(
                      'Ressenti',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    Text(
                      '${weather.feelsLike.toStringAsFixed(1)}°C',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Méthode pour obtenir l'icône météo en fonction de la météo
  /// et usage de FontAwesome pour des temps spécifiques (jour et nuit)
  Widget getIcon(weather){
    if (!['01d', '01n'].contains(weather.icon.toString())){
      return Image.network(
        weather.iconUrl,
        width: 85,
        height: 85,
        errorBuilder: (context, error, stackTrace) =>
            Icon(
              Icons.cloud_off,
              size: 85,
              color: Colors.grey[400],
            ),
      );
    }else{
      var icon = weather.icon == "01d" ? FontAwesomeIcons.solidSun : FontAwesomeIcons.solidMoon;
      return Icon(
        icon,
        size: 85,
        color: Colors.yellow[700],
      );
    }
  }
}



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';


/// UtilsService class to provide utility methods for the app
class UtilsService {

  /// Method to get the localized day name
  static String getLocalizedDayName(DateTime date, BuildContext context) {
    final today = DateTime.now();
    final locale = Localizations.localeOf(context).toString();
    if (date.day == today.day + 1) {
      return locale == 'fr_FR' ? 'demain' : 'tomorrow';
    }
    if (locale == 'fr_FR') {
      return DateFormat.EEEE("fr").format(date);
    }
    return DateFormat.EEEE().format(date);
  }

  /// Method to set the first letter to uppercase
  static String setFirstLetterToUpperCase(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  static IconData getWeatherIcon(String icon) {
    switch (icon) {
      case '01d':
        return FontAwesomeIcons.solidSun;
      case '01n':
        return FontAwesomeIcons.solidMoon;
      case '02d':
        return FontAwesomeIcons.cloudSun;
      case '02n':
        return FontAwesomeIcons.cloudMoon;
      case '03d':
        return FontAwesomeIcons.cloud;
      case '03n':
        return FontAwesomeIcons.cloud;
      case '04d':
        return WeatherIcons.cloudy;
      case '04n':
        return WeatherIcons.cloudy;
      case '09d':
        return FontAwesomeIcons.cloudShowersHeavy;
      case '09n':
        return FontAwesomeIcons.cloudShowersHeavy;
      case '10d':
        return FontAwesomeIcons.cloudSunRain;
      case '10n':
        return FontAwesomeIcons.cloudMoonRain;
      case '11d':
        return FontAwesomeIcons.cloudBolt;
      case '11n':
        return FontAwesomeIcons.cloudBolt;
      case '13d':
        return FontAwesomeIcons.snowflake;
      case '13n':
        return FontAwesomeIcons.snowflake;
      case '50d':
        return FontAwesomeIcons.smog;
      case '50n':
        return FontAwesomeIcons.smog;
      default:
        return FontAwesomeIcons.circleQuestion;
    }
  }
}

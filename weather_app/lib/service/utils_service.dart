import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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

  static IconData getWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'ciel dégagé':
        return FontAwesomeIcons.sun;
      case 'quelques nuages':
        return FontAwesomeIcons.cloudSun;
      case 'nuages épars':
        return FontAwesomeIcons.cloud;
      case 'nuages fragmentés':
        return FontAwesomeIcons.cloudMeatball;
      case 'averse de pluie':
        return FontAwesomeIcons.cloudShowersHeavy;
      case 'pluie':
        return FontAwesomeIcons.cloudRain;
      case 'orages':
        return FontAwesomeIcons.bolt;
      case 'neige':
        return FontAwesomeIcons.snowflake;
      case 'brouillard':
        return FontAwesomeIcons.smog;
      default:
        return FontAwesomeIcons.circleQuestion; // Default icon for unknown weather
    }
  }
}

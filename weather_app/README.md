# weather_app

This project is a Flutter application that displays the current weather and weather forecast for a given city using the [OpenWeatherMap](https://openweathermap.org/) API.

## Auteur 
- **[Eric Gilles](https://github.com/eric-gilles)**

## Application de Météo - [Weather App](https://github.com/eric-gilles/FlutterTP2/tree/main/weather_app)
This application uses the [OpenWeatherMap](https://openweathermap.org/) API to display the current weather and weather forecast for a given city:
- Search for the weather for a city by entering its name
- Display of the current weather
- Display of the weather forecast for the next 5 days

The weather is displayed in the form of cards for each day with the following information:
- Date
- Weather icon
- Weather description
- Temperature
- Humidity
- Wind speed
- Feels like temperature

## Online Access

Also available online via the following [Appetize](https://appetize.io/) link:

- [Weather App - Appetize](https://appetize.io/app/b_km7dibd7ult4kdzdktphdjhsaq)


## Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/eric-gilles/FlutterTP2
    ```

2. Access the directory of the desired project:
    ```bash
    cd FlutterTP1/weather_app/
    ```
3. Install the dependencies:
    ```bash
    flutter pub get
    ```
4. Create a file named `.env` in the root directory of the project and add the following line with your OpenWeatherMap API key:
    ```bash
    API_KEY='YOUR_API_KEY_HERE'
    ```
## Execution in command line

To run the weather application, use the following command in the corresponding project directory:

```bash
flutter run -t lib/main.dart
```

## Execution with Android Studio

1. Open the project application with Android Studio.
2. Select an emulator or physical device to run the application.
2. Run the application by clicking on the "Run" button or using the keyboard shortcut `Shift + F10`.

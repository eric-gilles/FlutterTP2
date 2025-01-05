# TP2 Flutter - UE HAI912I
## TP2 - Gestion d'état Avancée (Provider, BLoC), Futures& Streams, Themes & Styling, Assets, and Animations

Ce projet contient trois applications développées en Flutter : 
- une version de l'application de quiz du [TP1](https://github.com/eric-gilles/FlutterTP1) en utilisant le package `provider`
- une version de l'application de quiz du [TP1](https://github.com/eric-gilles/FlutterTP1/tree/main/quizz_app) utilisant le package `bloc`
- une application de météo utilisant l'API d'[OpenWeatherMap](https://openweathermap.org/)

Ces applications ont été réalisées dans le cadre du TP2 Flutter du cours HAI912I - Développement mobile avancé, IOT et embarqué à l'Université de Montpellier.

## Auteur 
- **[Eric Gilles](https://github.com/eric-gilles)**

## Applications

### 1. Application de Quiz avec Provider - [Quiz App V2](https://github.com/eric-gilles/FlutterTP2/tree/main/quiz_app_v2)

Cette application propose les mêmes fonctionnalités que l'application de quiz du [TP1](https://github.com/eric-gilles/FlutterTP1/tree/main/quizz_app), mais utilise le package `provider` pour gérer l'état de l'application :
- Affichage des questions
- Choix de la réponse (oui ou non)
- Affichage de la progression
- Calcul et affichage du score
- Possibilité de recommencer le quiz

### 2. Application de Quiz avec BLoC - [Quiz App V3](https://github.com/eric-gilles/FlutterTP2/tree/main/quiz_app_v3)

Cette application propose les mêmes fonctionnalités que l'application de quiz du [TP1](https://github.com/eric-gilles/FlutterTP1/tree/main/quizz_app), mais utilise le package `bloc` pour gérer l'état de l'application :
- Affichage des questions
- Choix de la réponse (oui ou non)
- Affichage de la progression
- Calcul et affichage du score
- Possibilité de recommencer le quiz

### 3. Application de Météo - [Weather App](https://github.com/eric-gilles/FlutterTP2/tree/main/weather_app)
Cette application utilise l'API d'[OpenWeatherMap](https://openweathermap.org/) pour afficher la météo actuelle et les prévisions météorologiques d'une ville donnée :
- Recherche de la météo pour une ville en entrant son nom
- Affichage de la météo actuelle
- Affichage des prévisions météorologiques pour les 5 prochains jours

La météo est affichée sous forme de cartes pour chaque jour avec les informations suivantes :
- Date
- Icone météo
- Description de la météo
- Température
- Humidité
- Vitesse du vent
- Température ressentie

## Accès en ligne

Également disponible en ligne via les liens [Appetize](https://appetize.io/) suivants :
- [Quiz App V2 - Appetize](https://appetize.io/app/b_ud5okbdylv5tnjglsrbsisd6ly)

- [Quiz App V3 - Appetize](https://appetize.io/app/b_7g34ytjrsclldjqmabosxmxeni)

- [Weather App - Appetize](https://appetize.io/app/b_km7dibd7ult4kdzdktphdjhsaq)

## Prérequis

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK

## Installation

1. Clonez le dépôt :
    ```bash
    git clone https://github.com/eric-gilles/FlutterTP2
    ```
2. Accédez au répertoire du projet souhaité :
    ```bash
    cd FlutterTP1/[quiz_app_v2|quiz_app_v3|weather_app]
    ```
3. Installez les dépendances :
    ```bash
    flutter pub get
    ```
4. Pour l'application `weather_app`, créez un fichier nommé `.env` dans le répertoire racine du projet et ajoutez la ligne suivante avec votre clé [API OpenWeatherMap](https://home.openweathermap.org/api_keys) :
    ```bash
    API_KEY='VOTRE_CLE_API_ICI'
    ```

## Exécution en ligne de commande

Pour exécuter l'application de carte de profil ou l'application de quiz, utilisez la commande suivante dans le répertoire du projet correspondant :

```bash
flutter run -t lib/main.dart
```

## Exécution avec Android Studio

1. Ouvrez le projet de l'application souhaitée avec Android Studio.
2. Sélectionnez un émulateur ou un appareil physique pour exécuter l'application.
2. Exécutez l'application en cliquant sur le bouton "Run" ou en utilisant le raccourci clavier `Shift + F10`.

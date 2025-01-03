import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_v2/provider/quiz_provider.dart';
import 'package:quiz_app_v2/screens/quiz_home_page.dart';
import 'package:quiz_app_v2/screens/quiz_page.dart';
import 'package:quiz_app_v2/screens/quiz_result_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizProvider>(create: (context) => QuizProvider()),
      ],
      child: const QuizApp(),
      ),
  );
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizHomePage(),
      initialRoute: '/',
      routes: {
        '/quiz': (context) => const QuizPage(title: 'Quiz Page'),
        '/result': (context) => const QuizResultPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_v3/blocs/quiz_bloc.dart';
import 'package:quiz_app_v3/blocs/quiz_event.dart';
import 'package:quiz_app_v3/repository/question_repository.dart';
import 'package:quiz_app_v3/screens/quiz_home_page.dart';
import 'package:quiz_app_v3/screens/quiz_page.dart';
import 'package:quiz_app_v3/screens/quiz_result_page.dart';

void main() {
  runApp(const QuizApp());
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
        '/quiz': (context) => BlocProvider(
          create: (_) => QuizBloc(QuestionRepository())..add(StartQuizEvent()),
          child: const QuizPage(title: 'Questions'),
        ),
        '/result': (context) => const QuizResultPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

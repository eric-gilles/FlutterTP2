import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_v3/business_logic/blocs/quiz_bloc.dart';
import 'package:quiz_app_v3/business_logic/events/quiz_event.dart';
import 'package:quiz_app_v3/data/repository/question_repository.dart';
import 'package:quiz_app_v3/presentation/screens/quiz_home_page.dart';
import 'package:quiz_app_v3/presentation/screens/quiz_page.dart';
import 'package:quiz_app_v3/presentation/screens/quiz_result_page.dart';

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

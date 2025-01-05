import 'package:flutter/material.dart';
import 'package:quiz_app_v2/data/model/question.dart';
import 'package:quiz_app_v2/data/repository/question_repository.dart';

class QuizProvider extends ChangeNotifier {
  late final QuestionRepository _questionRepository;
  int _index = 0;
  int _score = 0;

  QuizProvider(){
    _questionRepository = QuestionRepository();
  }

  List<Question> get questions => _questionRepository.questions;
  int get currentIndex => _index;
  int get score => _score;

  Question get currentQuestion => _questionRepository.questions[_index];

  bool checkAnswer(bool userChoice) {
    bool isCorrect = userChoice == questions[_index].isCorrect;

    if (isCorrect) {
      _score++;
    }

    // Notify listeners to update the UI (show feedback, etc.)
    notifyListeners();
    return isCorrect;
  }

  void nextQuestion(BuildContext context) {
    if (_index < questions.length - 1) {
      _index++;
    } else {
      // Go to result screen when quiz is finished
      // Handle navigation here in your QuizPage
      Navigator.pushNamed(context, '/result', arguments: [_score, _questionRepository.questions.length]);
      _index = 0;
      _score = 0;
    }
    notifyListeners();
  }
}

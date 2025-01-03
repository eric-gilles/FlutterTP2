import 'package:quiz_app_v2/model/question.dart';

class QuestionRepository {
  final List<Question> _questions = [
    Question(questionText: 'Le requin est-il l’animal le plus dangereux pour l’homme ?', isCorrect: false, questionImage: 'assets/img/q1.png'),
    Question(questionText: 'Le Mont Fuji au Japon est un volcan ?', isCorrect: true, questionImage: 'assets/img/q2.png'),
    Question(questionText: 'One Piece est-il le meilleur manga ?', isCorrect: true, questionImage: 'assets/img/q3.png'),
    Question(questionText: 'Une Supernova est-elle une naissance d’étoile ?', isCorrect: false, questionImage: 'assets/img/q4.png'),
    Question(questionText: 'Le soleil représente 99,8% du poids total du Système solaire ?', isCorrect: true, questionImage: 'assets/img/q5.png'),
  ];

  List<Question> get questions => _questions;
}

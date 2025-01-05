// Events
abstract class QuizEvent {}

class StartQuizEvent extends QuizEvent {}

class AnswerQuestionEvent extends QuizEvent {
  final bool answer;

  AnswerQuestionEvent(this.answer);
}

class NextQuestionEvent extends QuizEvent {}

class RestartQuizEvent extends QuizEvent {}

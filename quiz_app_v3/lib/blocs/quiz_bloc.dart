import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_v3/blocs/quiz_event.dart';
import 'package:quiz_app_v3/blocs/quiz_state.dart';
import 'package:quiz_app_v3/repository/question_repository.dart';

// BLoc
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuestionRepository _questionRepository;
  int _score = 0;
  int _index = 0;

  QuizBloc(this._questionRepository) : super(QuizInitialState()) {
    // Register event handlers
    on<StartQuizEvent>(_onStartQuiz);
    on<AnswerQuestionEvent>(_onAnswerQuestion);
    on<NextQuestionEvent>(_onNextQuestion);
    on<RestartQuizEvent>(_onRestartQuiz);
  }

  void _onStartQuiz(StartQuizEvent event, Emitter<QuizState> emit) {
    _score = 0;
    _index = 0;

    emit(QuizInProgressState(
      currentQuestion: _questionRepository.questions[_index],
      score: _score,
      questionIndex: _index,
      totalQuestions: _questionRepository.questions.length,
    ));
  }

  void _onAnswerQuestion(AnswerQuestionEvent event, Emitter<QuizState> emit) {
    final isCorrect = event.answer == _questionRepository.questions[_index].isCorrect;

    if (isCorrect) _score++;

    // Emit feedback state
    emit(AnswerFeedbackState(isCorrect: isCorrect));
  }

  void _onNextQuestion(NextQuestionEvent event, Emitter<QuizState> emit) {
    if (_index < _questionRepository.questions.length - 1) {
      _index++;
      emit(QuizInProgressState(
        currentQuestion: _questionRepository.questions[_index],
        score: _score,
        questionIndex: _index,
        totalQuestions: _questionRepository.questions.length,
      ));
    } else {
      emit(QuizFinishedState(
        score: _score,
        totalQuestions: _questionRepository.questions.length,
      ));
    }
  }

  void _onRestartQuiz(RestartQuizEvent event, Emitter<QuizState> emit) {
    _score = 0;
    _index = 0;
    emit(QuizInProgressState(
      currentQuestion: _questionRepository.questions[_index],
      score: _score,
      questionIndex: _index,
      totalQuestions: _questionRepository.questions.length,
    ));
  }
}

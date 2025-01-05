import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_v3/business_logic/blocs/quiz_bloc.dart';
import 'package:quiz_app_v3/business_logic/events/quiz_event.dart';
import 'package:quiz_app_v3/business_logic/states/quiz_state.dart';
import 'package:quiz_app_v3/data/repository/question_repository.dart';

class QuizPage extends StatelessWidget {
  final String title;

  const QuizPage({super.key, required this.title});

  // Helper method to show answer feedback
  void showAnswerFeedback(BuildContext context, bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(
          alignment: Alignment.center,
          child: Text(
            isCorrect ? 'Correct!' : 'Incorrect!',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        duration: const Duration(milliseconds: 500), // Adjust duration if needed
        backgroundColor: isCorrect ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(QuestionRepository())..add(StartQuizEvent()),
      child: BlocListener<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizFinishedState) {
            // Navigate to QuizResultPage when the quiz is finished
            Navigator.pushReplacementNamed(
              context,
              '/result',
              arguments: [state.score, state.totalQuestions],
            );
          }

          // Show SnackBar when an answer is submitted
          if (state is AnswerFeedbackState) {
            // Use your custom method to show feedback
            showAnswerFeedback(context, state.isCorrect);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Colors.blueGrey[50],
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state is QuizInProgressState) {
                return _buildQuizContent(context, state);
              } else if (state is QuizInitialState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text("Unexpected State"));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuizContent(BuildContext context, QuizInProgressState state) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blueGrey[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Question ${state.questionIndex + 1} / ${state.totalQuestions}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 180),
              ],
            ),
            // Display question image
            if (state.currentQuestion.questionImage.isNotEmpty)
              Image.asset(
                state.currentQuestion.questionImage,
                height: 200,
              ),
            const SizedBox(height: 20),
            // Question text
            Text(
              state.currentQuestion.questionText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Answer buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Dispatch AnswerQuestionEvent and NextQuestionEvent
                    context.read<QuizBloc>().add(AnswerQuestionEvent(true));
                    context.read<QuizBloc>().add(NextQuestionEvent());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text(
                    'Vrai',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<QuizBloc>().add(AnswerQuestionEvent(false));
                    context.read<QuizBloc>().add(NextQuestionEvent());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text(
                    'Faux',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
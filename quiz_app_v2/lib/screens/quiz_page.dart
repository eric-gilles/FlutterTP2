import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_v2/provider/quiz_provider.dart';

class QuizPage extends StatelessWidget {
  final String title;
  const QuizPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        final currentQuestion = quizProvider.currentQuestion;

        // Méthode pour afficher un SnackBar de la réponse
        void showAnswerFeedback(bool isCorrect) {
          // Show a SnackBar with the answer feedback
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Align(
                alignment: Alignment.center,
                child: Text(
                  isCorrect ? 'Correct!' : 'Incorrect!',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              duration: const Duration(milliseconds: 300),
              backgroundColor: isCorrect ? Colors.green : Colors.red,
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueGrey[50],
          ),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Question ${quizProvider.currentIndex + 1} / ${quizProvider.questions.length}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 180),
                    ],
                  ),
                  if (currentQuestion.questionImage.isNotEmpty)
                    Image.asset(
                      currentQuestion.questionImage,
                      height: 200,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      currentQuestion.questionText,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          bool isCorrect = quizProvider.checkAnswer(true);
                          quizProvider.nextQuestion(context);
                          showAnswerFeedback(isCorrect);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          'Vrai',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          bool isCorrect = quizProvider.checkAnswer(false);
                          quizProvider.nextQuestion(context);
                          showAnswerFeedback(isCorrect);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        ),
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
          ),
        );
      },
    );
  }
}

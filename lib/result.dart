import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetQuiz;
  const Result(this.totalScore, this.resetQuiz, {super.key});

  String get quizResult {
    String? result;

    if (totalScore < 8) {
      result = 'You are innocent person';
    } else if (totalScore < 12) {
      result = "You are close to a innpcent person.";
    } else if (totalScore < 16) {
      result = "You are a bad person";
    } else {
      result = "You are ... person";
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            quizResult,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: resetQuiz,
            child: const Text('Reset Quiz'),
          ),
        ],
      ),
    );
  }
}

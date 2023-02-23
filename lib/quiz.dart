import 'package:flutter/material.dart';

import './questions.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  const Quiz(
      {super.key,
      required this.questionIndex,
      required this.answerQuestion,
      required this.questions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText'].toString()),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            answerText: answer['text'].toString(),
            pressHandler: () => answerQuestion(answer['score']),
          );
        }),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer(
      {super.key, required this.answerText, required this.pressHandler});
  final String answerText;
  final VoidCallback pressHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      // alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: pressHandler,
        child: Text(answerText),
      ),
    );
  }
}

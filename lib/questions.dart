import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  const Question(this._questionText, {super.key});
  final String _questionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      child: Text(
        _questionText,
        style: const TextStyle(fontSize: 28),
      ),
    );
  }
}

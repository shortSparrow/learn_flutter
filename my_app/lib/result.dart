import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScoreResult;
  final VoidCallback restartQuiz;

  const Result(
      {required this.totalScoreResult, required this.restartQuiz, super.key});

  String get resultPhrase {
    var resText;

    if (totalScoreResult <= 8) {
      resText = 'You are awesome!';
    } else if (totalScoreResult <= 12) {
      resText = 'Pretty likeable!';
    } else if (totalScoreResult <= 16) {
      resText = 'You are strange!';
    } else {
      resText = 'You are so bad!';
    }

    return resText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          OutlinedButton(
            onPressed: restartQuiz,
            child: const Text('RESTART'),
          )
        ],
      ),
    );
  }
}

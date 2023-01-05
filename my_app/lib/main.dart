import 'package:flutter/material.dart';
import 'package:my_app/quiz.dart';
import 'package:my_app/result.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _questionIndex = 0;
  int _totalScore = 0;
  final _questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Green', 'score': 10},
        {'text': 'Yellow', 'score': 5},
        {'text': 'Blue', 'score': 2},
      ]
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Hors', 'score': 6},
        {'text': 'Warn', 'score': 3},
        {'text': 'Duck', 'score': 1},
      ]
    },
    {
      'questionText': 'What\'s your favorite programming language?',
      'answers': [
        {'text': 'Kotlin', 'score': 6},
        {'text': 'JS', 'score': 3},
        {'text': 'Dart', 'score': 1},
      ]
    },
  ];

  void _answerQuestion(int score) {
    if (_questionIndex < _questions.length) {}

    setState(() {
      _totalScore += score;
      _questionIndex = _questionIndex + 1;
    });
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('My first app'),
            centerTitle: true,
          ),
          body: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questions: _questions,
                  questionIndex: _questionIndex,
                )
              : Result(
                  totalScoreResult: _totalScore,
                  restartQuiz: _restartQuiz,
                )),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:my_app/question.dart';

import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final void Function(int) answerQuestion;

  const Quiz({
    required this.answerQuestion,
    required this.questions,
    required this.questionIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(question[_questionIndex]),
        Question(questions[questionIndex]['questionText'] as String),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) => Answer(() => answerQuestion(answer['score'] as int),
                answer['text'] as String))
            .toList()

        // ElevatedButton(onPressed: () => {}, child: const Text('Answer 2')),
        // ElevatedButton(onPressed: () {}, child: const Text('Answer 3')),
      ],
    );
  }
}

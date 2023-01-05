import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: selectHandler,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
          ),
          child: Text(answerText)),
    );
  }
}

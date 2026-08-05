import 'package:flutter/material.dart';

class HangmanWordLetter extends StatelessWidget {
  final String letter;
  final bool isMatched;

  const HangmanWordLetter({
    super.key,
    required this.letter,
    required this.isMatched,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      padding: EdgeInsets.only(bottom: 4.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black87)),
      ),
      alignment: Alignment.center,
      child: Text(
        isMatched ? letter : "",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.black87,
        ),
      ),
    );
  }
}

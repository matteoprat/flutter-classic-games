import 'package:flutter/material.dart';

class HangmanKeyboardLetter extends StatelessWidget {
  final String letter;
  final bool isError;
  final bool isMatched;
  final Function(String letter) onLetterTap;
  const HangmanKeyboardLetter({
    super.key,
    required this.letter,
    required this.isError,
    required this.isMatched,
    required this.onLetterTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isUsed = isMatched || isError;

    return GestureDetector(
      onTap: isUsed ? null : () => onLetterTap(letter),
      child: AnimatedContainer(
        width: 34,
        height: 42,
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: isMatched
              ? Colors.green[100]
              : (isError ? Colors.red[100] : Colors.white),
          border: Border.all(
            color: isMatched
                ? Colors.green[700]!
                : (isError ? Colors.red[700]! : Colors.black54),
            width: isMatched || isError ? 3.0 : 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
          boxShadow: [
            BoxShadow(
              color: isMatched
                  ? Colors.green.withValues(alpha: 0.3)
                  : Colors.black12,
              blurRadius: isMatched ? 8 : 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

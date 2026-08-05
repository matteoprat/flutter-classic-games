import 'package:flutter/material.dart';

class MastermindFeedbackGrid extends StatelessWidget {
  final List<Color>? attemptResult;

  const MastermindFeedbackGrid({super.key, this.attemptResult});

  Widget _getFeedbackPeg(int index) {
    Color pegColor = Colors.transparent;
    Color borderColor = Colors.grey[300]!;

    if (attemptResult != null && index < attemptResult!.length) {
      pegColor = attemptResult![index];
      borderColor = Colors.black87;
    }

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: pegColor,
        border: Border.all(color: borderColor, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[_getFeedbackPeg(0), _getFeedbackPeg(1)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[_getFeedbackPeg(2), _getFeedbackPeg(3)],
          ),
        ],
      ),
    );
  }
}

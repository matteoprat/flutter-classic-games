import 'package:classic_games/data/mastermind_color.dart';
import 'package:classic_games/games/mastermind_game/components/mastermind_row.dart';
import 'package:flutter/material.dart';

class MastermindBoard extends StatelessWidget {
  final int maxAttempts;
  final List<List<MastermindColor?>> attemtpedCombinations;
  final List<List<Color>> attempResults;
  final Function(int positionIndex, MastermindColor selectedColor)
  onColorChanged;
  final VoidCallback onSubmitAttempt;

  const MastermindBoard({
    super.key,
    required this.maxAttempts,
    required this.attemtpedCombinations,
    required this.attempResults,
    required this.onSubmitAttempt,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    int activeRowIndex = attemtpedCombinations.length - 1;

    return ListView.builder(
      itemCount: maxAttempts,
      itemBuilder: (BuildContext context, int index) {
        bool isActive = index == activeRowIndex;

        List<MastermindColor?> colors = index < attemtpedCombinations.length
            ? attemtpedCombinations[index]
            : [];

        List<Color>? result = index < attempResults.length
            ? attempResults[index]
            : null;

        return MastermindRow(
          rowIndex: index,
          isActive: isActive,
          selectedColors: colors,
          attemptResult: result,
          onColorChanged: onColorChanged,
          onSubmit: onSubmitAttempt,
        );
      },
    );
  }
}

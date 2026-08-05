import 'package:classic_games/data/mastermind_color.dart';
import 'package:classic_games/games/mastermind_game/components/mastermind_feedback_grid.dart';
import 'package:classic_games/games/mastermind_game/components/mastermind_peg_dropdown.dart';
import 'package:flutter/material.dart';

class MastermindRow extends StatelessWidget {
  final int rowIndex;
  final bool isActive;
  final List<MastermindColor?> selectedColors;
  final List<Color>? attemptResult;
  final Function(int positionIndex, MastermindColor selectedColor)
  onColorChanged;
  final VoidCallback onSubmit;

  const MastermindRow({
    super.key,
    required this.rowIndex,
    required this.isActive,
    required this.selectedColors,
    this.attemptResult,
    required this.onSubmit,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isComplete =
        selectedColors.length == 4 && !selectedColors.contains(null);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.brown[50] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isActive ? Colors.brown : Colors.grey[300]!,
          width: isActive ? 2.0 : 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "#${rowIndex + 1}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.brown : Colors.grey[400],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: List.generate(4, (slotIndex) {
              MastermindColor? currentColor = slotIndex < selectedColors.length
                  ? selectedColors[slotIndex]
                  : null;
              return MastermindPegDropdown(
                currentColor: currentColor,
                isActive: isActive,
                onColorSelected: (MastermindColor? newColor) {
                  if (newColor != null) {
                    onColorChanged(slotIndex, newColor);
                  }
                },
              );
            }),
          ),
          IconButton(
            onPressed: isActive && isComplete ? onSubmit : null,
            icon: const Icon(Icons.check_circle_rounded),
            color: isActive && isComplete ? Colors.green : Colors.grey[300],
          ),
          MastermindFeedbackGrid(attemptResult: attemptResult),
        ],
      ),
    );
  }
}

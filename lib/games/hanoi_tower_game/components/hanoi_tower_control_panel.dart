import 'package:classic_games/data/hanoi_tower_difficulty.dart';
import 'package:flutter/material.dart';

class HanoiTowerControlPanel extends StatelessWidget {
  final HanoiTowerDifficulty currentDifficulty;
  final Function(HanoiTowerDifficulty) switchDifficulty;

  const HanoiTowerControlPanel({
    super.key,
    required this.currentDifficulty,
    required this.switchDifficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: HanoiTowerDifficulty.values.map((difficulty) {
                bool isSelected = currentDifficulty == difficulty;
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: ChoiceChip(
                    label: Text(difficulty.label),
                    selected: isSelected,
                    selectedColor: difficulty.color,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 12,
                    ),
                    showCheckmark: false,
                    onSelected: (bool selected) {
                      if (selected) {
                        switchDifficulty(difficulty);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

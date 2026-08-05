import 'package:classic_games/data/memory_difficulty.dart';
import 'package:classic_games/data/memory_theme.dart';
import 'package:flutter/material.dart';

class MemoryControlPanel extends StatelessWidget {
  final MemoryTheme currentTheme;
  final MemoryDifficulty currentDifficulty;
  final Function(MemoryTheme) switchTheme;
  final Function(MemoryDifficulty) switchDifficulty;

  const MemoryControlPanel({
    super.key,
    required this.currentTheme,
    required this.currentDifficulty,
    required this.switchTheme,
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
        children: <Widget>[
          DropdownButton<MemoryTheme>(
            value: currentTheme,
            underline: const SizedBox(),
            icon: Icon(Icons.arrow_drop_down, color: currentTheme.themeColor),
            items: MemoryTheme.values.map((MemoryTheme theme) {
              return DropdownMenuItem<MemoryTheme>(
                value: theme,
                child: Row(
                  children: <Widget>[
                    Icon(theme.icons[0], color: theme.themeColor, size: 20),
                    const SizedBox(width: 8.0),
                    Text(
                      theme.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (MemoryTheme? newTheme) {
              if (newTheme != null) {
                switchTheme(newTheme);
              }
            },
          ),
          const Spacer(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: MemoryDifficulty.values.map((difficulty) {
                bool isSelected = currentDifficulty == difficulty;
                String label;
                switch (difficulty) {
                  case MemoryDifficulty.easy:
                    label = "Easy";
                    break;
                  case MemoryDifficulty.medium:
                    label = "Medium";
                    break;
                  case MemoryDifficulty.hard:
                    label = "Hard";
                    break;
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: ChoiceChip(
                    label: Text(label),
                    selected: isSelected,
                    selectedColor: currentTheme.themeColor,
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

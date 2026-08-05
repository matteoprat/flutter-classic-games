import 'package:classic_games/data/hangman_category.dart';
import 'package:flutter/material.dart';

class HangmanControlPanel extends StatelessWidget {
  final HangmanCategory currentCategory;
  final Function(HangmanCategory) switchCategory;

  const HangmanControlPanel({
    super.key,
    required this.currentCategory,
    required this.switchCategory,
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
          DropdownButton<HangmanCategory>(
            value: currentCategory,
            underline: const SizedBox(),
            icon: Icon(Icons.arrow_drop_down, color: currentCategory.color),
            items: HangmanCategory.values.map((HangmanCategory category) {
              return DropdownMenuItem<HangmanCategory>(
                value: category,
                child: Row(
                  children: <Widget>[
                    Icon(category.icon, color: category.color, size: 20),
                    const SizedBox(width: 8.0),
                    Text(
                      category.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (HangmanCategory? newCategory) {
              if (newCategory != null) {
                switchCategory(newCategory);
              }
            },
          ),
        ],
      ),
    );
  }
}

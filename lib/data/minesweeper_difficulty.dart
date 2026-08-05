import 'package:flutter/material.dart';

enum MinesweeperDifficulty {
  easy(label: "Easy", rows: 8, columns: 8, mines: 10, color: Colors.green),
  medium(
    label: "Medium",
    rows: 10,
    columns: 10,
    mines: 18,
    color: Colors.orange,
  ),
  hard(label: "Hard", rows: 12, columns: 12, mines: 30, color: Colors.red);

  final String label;
  final int rows;
  final int columns;
  final int mines;
  final Color color;

  const MinesweeperDifficulty({
    required this.label,
    required this.rows,
    required this.columns,
    required this.mines,
    required this.color,
  });
}

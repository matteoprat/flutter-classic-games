import 'package:flutter/material.dart';

enum HanoiTowerDifficulty {
  easy(color: Colors.green, label: "Easy", discs: 3),
  medium(color: Colors.orange, label: "Medium", discs: 4),
  hard(color: Colors.red, label: "Hard", discs: 5);

  final int discs;
  final String label;
  final Color color;

  const HanoiTowerDifficulty({
    required this.label,
    required this.color,
    required this.discs,
  });
}

import 'package:classic_games/data/game_result/game_result.dart';
import 'package:flutter/material.dart';

enum SimonGameResult implements GameResult {
  lose(
    title: "Game Over",
    message: "You matched #matched# sequences!",
    icon: Icons.assignment_rounded,
    iconColor: Colors.blueAccent,
  );

  @override
  final String title;

  @override
  final String message;

  @override
  final IconData icon;

  @override
  final Color iconColor;

  const SimonGameResult({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  });
}

import 'package:classic_games/data/game_result/game_result.dart';
import 'package:flutter/material.dart';

enum MemoryGameResult implements GameResult {
  win(
    title: "Congratulations!",
    message:
        "You win the game of level #difficultyLevel# with #guesses# guesses",
    icon: Icons.emoji_events_rounded,
    iconColor: Colors.amber,
  );

  @override
  final String title;

  @override
  final String message;

  @override
  final IconData icon;

  @override
  final Color iconColor;

  const MemoryGameResult({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  });
}

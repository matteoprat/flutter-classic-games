import 'package:classic_games/data/game_result/game_result.dart';
import 'package:flutter/material.dart';

enum MastermindGameResult implements GameResult {
  win(
    title: "Congratulations!",
    message: "You win the game in #attemptedCombinations# attempts.",
    icon: Icons.emoji_events_rounded,
    iconColor: Colors.amber,
  ),
  lose(
    title: "You lose.",
    message: "You could not beat the game in #attemptedCombinations#.",
    icon: Icons.sentiment_dissatisfied_rounded,
    iconColor: Colors.blueGrey,
  );

  @override
  final String title;

  @override
  final String message;

  @override
  final IconData icon;

  @override
  final Color iconColor;

  const MastermindGameResult({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  });
}

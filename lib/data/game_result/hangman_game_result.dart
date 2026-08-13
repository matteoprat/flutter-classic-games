import 'package:classic_games/data/game_result/game_result.dart';
import 'package:flutter/material.dart';

enum HangmanGameResult implements GameResult {
  win(
    title: "Congratulations!",
    message:
        "You found the word #word# with #remainingAttempts# attempts left.",
    icon: Icons.emoji_events_rounded,
    iconColor: Colors.amber,
  ),
  lose(
    title: "You lose.",
    message: "You didn't find the word #word#.",
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

  const HangmanGameResult({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  });
}

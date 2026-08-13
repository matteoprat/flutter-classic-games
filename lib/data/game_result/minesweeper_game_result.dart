import 'package:classic_games/data/game_result/game_result.dart';
import 'package:flutter/material.dart';

enum MinesweeperGameResult implements GameResult {
  win(
    title: "Congratulations!",
    message: "You managed to win the game at #difficulty# level.",
    icon: Icons.emoji_events_rounded,
    iconColor: Colors.amber,
  ),
  lose(
    title: "You lose.",
    message: "You accidentally touch a mine. Ouch!",
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

  const MinesweeperGameResult({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  });
}

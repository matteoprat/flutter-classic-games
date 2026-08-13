import 'package:classic_games/data/game_result/game_result.dart';
import 'package:flutter/material.dart';

enum FifteenGameResult implements GameResult {
  win(
    title: "Congratulations!",
    message: "You beat the game in #totalMoves# moves.",
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

  const FifteenGameResult({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  });
}

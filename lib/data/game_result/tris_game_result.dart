import 'package:classic_games/data/game_result/game_result.dart';
import 'package:flutter/material.dart';

enum TrisGameResult implements GameResult {
  win(
    title: "Congratulations!",
    message: "You managed to win the game against CPU.",
    icon: Icons.emoji_events_rounded,
    iconColor: Colors.amber,
  ),
  even(
    title: "Game is even.",
    message: "You didn't win but you managed to prevent the cpu from winning.",
    icon: Icons.handshake_rounded,
    iconColor: Colors.blueGrey,
  ),
  lose(
    title: "You lose.",
    message: "The CPU managed to win the game.",
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

  const TrisGameResult({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  });
}

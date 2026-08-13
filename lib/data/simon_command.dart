import 'package:flutter/material.dart';

enum SimonCommand {
  green(
    color: Color(0xFF006400),
    activeColor: Color(0xFF00FF00),
    soundAsset: 'sounds/simon/green.mp3',
  ),
  red(
    color: Color(0xFF8B0000),
    activeColor: Color(0xFFFF0000),
    soundAsset: 'sounds/simon/red.mp3',
  ),
  yellow(
    color: Color(0xFF9E8B00),
    activeColor: Color(0xFFFFFF00),
    soundAsset: 'sounds/simon/yellow.mp3',
  ),
  blue(
    color: Color(0xFF00008B),
    activeColor: Color(0xFF00FFFF),
    soundAsset: 'sounds/simon/blue.mp3',
  );

  final Color color;
  final Color activeColor;
  final String soundAsset;

  const SimonCommand({
    required this.color,
    required this.activeColor,
    required this.soundAsset,
  });
}

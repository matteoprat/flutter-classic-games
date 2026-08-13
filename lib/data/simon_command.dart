import 'package:flutter/material.dart';

enum SimonCommand {
  green(
    color: Color(0xFF006400),
    activeColor: Color(0xFF00FF00),
    frequency: 220.0,
  ),
  red(
    color: Color(0xFF8B0000),
    activeColor: Color(0xFFFF0000),
    frequency: 277.18,
  ),
  yellow(
    color: Color(0xFF9E8B00),
    activeColor: Color(0xFFFFFF00),
    frequency: 329.63,
  ),
  blue(
    color: Color(0xFF00008B),
    activeColor: Color(0xFF00FFFF),
    frequency: 164.81,
  );

  final Color color;
  final Color activeColor;
  final double frequency;

  const SimonCommand({
    required this.color,
    required this.activeColor,
    required this.frequency,
  });
}

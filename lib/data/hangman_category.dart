import 'package:flutter/material.dart';

enum HangmanCategory {
  animals(
    label: "Animals",
    message: "Guess the Animal",
    icon: Icons.pets_rounded,
    color: Colors.amber,
  ),
  food(
    label: "Food",
    message: "Guess the Food",
    icon: Icons.local_pizza_rounded,
    color: Colors.red,
  ),
  vehicles(
    label: "Vehicles",
    message: "Guess the Vehicle",
    icon: Icons.emoji_transportation_rounded,
    color: Colors.blue,
  );

  final String label;
  final String message;
  final IconData icon;
  final Color color;

  const HangmanCategory({
    required this.label,
    required this.message,
    required this.icon,
    required this.color,
  });
}

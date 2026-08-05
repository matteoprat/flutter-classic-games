import 'package:flutter/material.dart';

enum TrisActor {
  human(name: "human", icon: Icons.close_rounded, color: Colors.blue),
  cpu(name: "cpu", icon: Icons.circle_outlined, color: Colors.red);

  final String name;
  final IconData icon;
  final Color color;

  const TrisActor({
    required this.name,
    required this.icon,
    required this.color,
  });
}

import 'package:flutter/material.dart';

enum MastermindColor {
  red(color: Colors.red),
  blue(color: Colors.blue),
  green(color: Colors.green),
  yellow(color: Colors.yellow),
  white(color: Colors.white),
  black(color: Colors.black);

  final Color color;

  const MastermindColor({required this.color});
}

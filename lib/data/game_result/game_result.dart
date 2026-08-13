import 'package:flutter/material.dart';

abstract class GameResult {
  String get title;
  String get message;
  IconData get icon;
  Color get iconColor;
}

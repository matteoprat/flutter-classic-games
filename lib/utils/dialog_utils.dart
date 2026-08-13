import 'package:classic_games/data/game_result/game_result.dart';
import 'package:classic_games/templates/endgame_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  void showEndGameDialog(
    BuildContext context,
    GameResult gameResult,
    Map<String, String>? messageReplacements,
    VoidCallback newGameAction,
  ) {
    String message = gameResult.message;

    if (messageReplacements != null) {
      messageReplacements.forEach(
        (String key, String value) => message = message.replaceAll(key, value),
      );
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EndGameDialog(
          title: gameResult.title,
          message: message,
          icon: gameResult.icon,
          iconColor: gameResult.iconColor,
          newGameAction: newGameAction,
        );
      },
    );
  }
}

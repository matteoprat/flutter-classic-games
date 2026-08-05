import 'package:classic_games/templates/endgame_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  void showEndGameDialog(BuildContext context, EndGameDialog endGameDialog) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return endGameDialog;
      },
    );
  }
}

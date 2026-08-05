import 'package:classic_games/data/mastermind_color.dart';
import 'package:classic_games/games/mastermind_game/components/mastermind_board.dart';
import 'package:classic_games/games/mastermind_game/components/mastermind_secret_header.dart';
import 'package:classic_games/templates/endgame_dialog.dart';
import 'package:classic_games/templates/game_container.dart';
import 'package:classic_games/utils/dialog_utils.dart';
import 'package:classic_games/utils/mastermind_utils.dart';
import 'package:flutter/material.dart';

class MastermindGame extends StatefulWidget {
  const MastermindGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MastermindGameState();
  }
}

class _MastermindGameState extends State<MastermindGame> {
  final DialogUtils dialogUtils = DialogUtils();
  bool _showSecretCombination = false;
  final int maxAttempts = 10;
  final MastermindUtils mastermindUtils = MastermindUtils();
  late List<MastermindColor> _secretCombination = mastermindUtils
      .getSecretCombination();
  List<List<MastermindColor?>> _attemptedCombinations = [];
  List<List<Color>> _attemptResults = [];

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _showSecretCombination = false;
      _secretCombination = mastermindUtils.getSecretCombination();
      _attemptedCombinations = [[]];
      _attemptResults = [];
    });
  }

  void _newGameAction() {
    Navigator.pop(context);
    _startGame();
  }

  void _onSubmitAttempt() {
    int currentCombinationIndex = _attemptedCombinations.length - 1;
    List<MastermindColor?> currentCombination =
        _attemptedCombinations[currentCombinationIndex];
    List<Color> attemptResult = mastermindUtils.attemptCombination(
      currentCombination,
      _secretCombination,
    );
    if (attemptResult.length == 4 &&
        attemptResult.every((Color color) => color == Colors.black)) {
      setState(() {
        _showSecretCombination = true;
        _attemptResults.add(attemptResult);
      });
      dialogUtils.showEndGameDialog(
        context,
        EndGameDialog(
          title: "Congratulations!",
          message:
              "You beat the game in ${_attemptedCombinations.length} attempts",
          icon: Icons.emoji_events_rounded,
          iconColor: Colors.amber,
          newGameAction: _newGameAction,
        ),
      );
    } else {
      List<List<MastermindColor?>> newAttemptedCombinations = [];
      newAttemptedCombinations.addAll(_attemptedCombinations);
      newAttemptedCombinations.add([]);
      setState(() {
        _attemptResults.add(attemptResult);
        if (_attemptResults.length == maxAttempts) {
          dialogUtils.showEndGameDialog(
            context,
            EndGameDialog(
              title: "You lose.",
              message:
                  "You could not beat the game in ${_attemptedCombinations.length} attempts, better luck next time!",
              icon: Icons.sentiment_dissatisfied_rounded,
              iconColor: Colors.blueGrey,
              newGameAction: _newGameAction,
            ),
          );
          _showSecretCombination = true;
        } else {
          _attemptedCombinations = newAttemptedCombinations;
        }
      });
    }
  }

  void _updateSlotColor(int slotIndex, MastermindColor color) {
    int activeRow = _attemptedCombinations.length - 1;
    setState(() {
      if (_attemptedCombinations[activeRow].length < 4) {
        _attemptedCombinations[activeRow] = List.filled(4, null);
      }
      _attemptedCombinations[activeRow][slotIndex] = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      title: "Mastermind",
      startGame: _startGame,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            MastermindSecretHeader(
              secretCombination: _secretCombination,
              showSecret: _showSecretCombination,
            ),
            Expanded(
              child: MastermindBoard(
                maxAttempts: maxAttempts,
                attemtpedCombinations: _attemptedCombinations,
                attempResults: _attemptResults,
                onColorChanged: _updateSlotColor,
                onSubmitAttempt: _onSubmitAttempt,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

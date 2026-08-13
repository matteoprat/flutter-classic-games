import 'package:classic_games/data/game_result/mastermind_game_result.dart';
import 'package:classic_games/data/mastermind_color.dart';
import 'package:classic_games/games/mastermind_game/components/mastermind_board.dart';
import 'package:classic_games/games/mastermind_game/components/mastermind_secret_header.dart';
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
    MastermindGameResult? gameResult;
    if (attemptResult.length == 4 &&
        attemptResult.every((Color color) => color == Colors.black)) {
      setState(() {
        _showSecretCombination = true;
        _attemptResults.add(attemptResult);
      });
      gameResult = MastermindGameResult.win;
    } else {
      List<List<MastermindColor?>> newAttemptedCombinations = [];
      newAttemptedCombinations.addAll(_attemptedCombinations);
      newAttemptedCombinations.add([]);
      setState(() {
        _attemptResults.add(attemptResult);
        if (_attemptResults.length == maxAttempts) {
          gameResult = MastermindGameResult.lose;
          _showSecretCombination = true;
        } else {
          _attemptedCombinations = newAttemptedCombinations;
        }
      });
    }
    if (gameResult != null) {
      dialogUtils.showEndGameDialog(context, gameResult!, <String, String>{
        "#attemptedCombinations#": _attemptedCombinations.length.toString(),
      }, _newGameAction);
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

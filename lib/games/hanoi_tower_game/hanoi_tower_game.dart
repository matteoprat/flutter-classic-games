import 'dart:math';

import 'package:classic_games/data/hanoi_tower_difficulty.dart';
import 'package:classic_games/data/game_result/hanoi_tower_game_result.dart';
import 'package:classic_games/data/hanoi_tower_move.dart';
import 'package:classic_games/data/hanoi_tower_move_validation.dart';
import 'package:classic_games/games/hanoi_tower_game/components/hanoi_tower_control_panel.dart';
import 'package:classic_games/games/hanoi_tower_game/components/hanoi_tower_stack.dart';
import 'package:classic_games/games/hanoi_tower_game/components/hanoi_tower_stats_panel.dart';
import 'package:classic_games/templates/game_container.dart';
import 'package:classic_games/utils/dialog_utils.dart';
import 'package:classic_games/utils/hanoi_tower_utils.dart';
import 'package:flutter/material.dart';

class HanoiTowerGame extends StatefulWidget {
  const HanoiTowerGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HanoiTowerGameState();
  }
}

class _HanoiTowerGameState extends State<HanoiTowerGame> {
  final HanoiTowerUtils hanoiTowerUtils = HanoiTowerUtils();
  final DialogUtils dialogUtils = DialogUtils();
  HanoiTowerDifficulty _currentDifficulty = HanoiTowerDifficulty.easy;
  late List<List<int?>> _currentBoard;
  bool _isGameOver = false;
  final List<String> _towerNames = ["A", "B", "C"];
  int _totalMoves = 0;
  int _perfectScore = 0;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _currentBoard = hanoiTowerUtils.getStartingBoard(
        _currentDifficulty.discs,
      );
      _isGameOver = false;
      _totalMoves = 0;
      _perfectScore = (pow(2, _currentDifficulty.discs) - 1).toInt();
    });
  }

  void _onMoveDisc(HanoiTowerMove move) {
    HanoiTowerMoveValidation moveValidation = hanoiTowerUtils.isValidMove(
      move,
      _currentBoard,
      _currentDifficulty.discs,
    );

    if (!moveValidation.isValid || _isGameOver) {
      return;
    }

    setState(() {
      _totalMoves++;
      _currentBoard[move.targetColumn][moveValidation.newColumnIndex!] =
          move.value;
      _currentBoard[move.currentCoordinates.x][move.currentCoordinates.y] =
          null;
      _isGameOver = hanoiTowerUtils.isWinningBoard(_currentBoard);
    });

    if (_isGameOver) {
      dialogUtils.showEndGameDialog(
        context,
        HanoiTowerGameResult.win,
        <String, String>{
          "#swaps#": _totalMoves.toString(),
          "#perfectScore#": _perfectScore.toString(),
        },
        _newGameAction,
      );
    }
  }

  void _switchDifficulty(HanoiTowerDifficulty newDifficulty) {
    setState(() {
      _currentDifficulty = newDifficulty;
    });
    _startGame();
  }

  void _newGameAction() {
    Navigator.pop(context);
    _startGame();
  }

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      title: "Tower of Hanoi",
      startGame: () => _startGame(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HanoiTowerControlPanel(
              currentDifficulty: _currentDifficulty,
              switchDifficulty: _switchDifficulty,
            ),
            SizedBox(height: 14),
            HanoiTowerStatsPanel(
              totalMoves: _totalMoves,
              perfectScore: _perfectScore,
            ),
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (int index) {
                  return HanoiTowerStack(
                    stack: _currentBoard[index],
                    label: _towerNames[index],
                    discs: _currentDifficulty.discs,
                    doMove: _onMoveDisc,
                    columnIndex: index,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

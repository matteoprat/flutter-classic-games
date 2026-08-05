import 'dart:async';

import 'package:classic_games/data/coordinate_class.dart';
import 'package:classic_games/data/minefield_cell.dart';
import 'package:classic_games/data/minesweeper_difficulty.dart';
import 'package:classic_games/games/minesweeper_game/components/minesweeper_control_panel.dart';
import 'package:classic_games/games/minesweeper_game/components/minesweeper_stats_panel.dart';
import 'package:classic_games/games/minesweeper_game/components/minesweeper_tile.dart';
import 'package:classic_games/templates/endgame_dialog.dart';
import 'package:classic_games/templates/game_container.dart';
import 'package:classic_games/utils/dialog_utils.dart';
import 'package:classic_games/utils/minesweeper_utils.dart';
import 'package:flutter/material.dart';

class MinesweeperGame extends StatefulWidget {
  const MinesweeperGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MinesweeperState();
  }
}

class _MinesweeperState extends State<MinesweeperGame> {
  MinesweeperUtils minesweeperUtils = MinesweeperUtils();
  DialogUtils dialogUtils = DialogUtils();
  Timer? _timer;
  late List<List<MinefieldCell>> _minefield;
  MinesweeperDifficulty _currentDifficulty = MinesweeperDifficulty.easy;
  bool _firstMove = true;
  bool _gameOver = false;
  int _revealedCells = 0;
  int _elapsedSeconds = 0;
  CoordinateClass? _explodedMine;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startGame(_currentDifficulty);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _startGame(MinesweeperDifficulty difficulty) {
    setState(() {
      _currentDifficulty = difficulty;
      _minefield = List.generate(
        difficulty.rows,
        (_) => List.generate(difficulty.columns, (_) => MinefieldCell()),
      );
      _firstMove = true;
      _revealedCells = 0;
      _gameOver = false;
      _explodedMine = null;
      _elapsedSeconds = 0;
    });
  }

  void _switchDifficulty(MinesweeperDifficulty difficulty) {
    setState(() {
      _currentDifficulty = difficulty;
    });
    _startGame(difficulty);
  }

  void _onLongPressTile(CoordinateClass coordinates) {
    setState(() {
      MinefieldCell cell = _minefield[coordinates.y][coordinates.x];
      if (!cell.isRevealed) {
        cell.toggleFlag();
      }
    });
  }

  void _onTapTile(CoordinateClass coordinates) {
    if (_firstMove) {
      List<List<MinefieldCell>> populatedMineField = minesweeperUtils
          .populateMineField(_minefield, _currentDifficulty, coordinates);
      setState(() {
        _minefield = populatedMineField;
        _firstMove = false;
      });
      _startTimer();
    }
    if (_minefield[coordinates.y][coordinates.x].isMine) {
      _stopTimer();
      setState(() {
        _gameOver = true;
        _explodedMine = coordinates;
      });
      dialogUtils.showEndGameDialog(
        context,
        EndGameDialog(
          title: "You lose.",
          message: "You accidentally touch a mine. Ouch!",
          icon: Icons.sentiment_dissatisfied_rounded,
          iconColor: Colors.blueGrey,
          newGameAction: _newGameAction,
        ),
      );
    }
    if (!_gameOver) {
      setState(() {
        _revealedCells += minesweeperUtils.revealCell(
          _minefield,
          _currentDifficulty,
          coordinates,
        );
      });
      int totalCells = _currentDifficulty.rows * _currentDifficulty.columns;
      if (_revealedCells == totalCells - _currentDifficulty.mines) {
        _stopTimer();
        setState(() {
          _gameOver = true;
        });
        dialogUtils.showEndGameDialog(
          context,
          EndGameDialog(
            title: "Congratulations!",
            message:
                "You managed to win the game at ${_currentDifficulty.label} level.",
            icon: Icons.emoji_events_rounded,
            iconColor: Colors.amber,
            newGameAction: _newGameAction,
          ),
        );
      }
    }
  }

  void _newGameAction() {
    Navigator.pop(context);
    _startGame(_currentDifficulty);
  }

  Widget _getGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _currentDifficulty.columns,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      itemCount: _currentDifficulty.columns * _currentDifficulty.rows,
      itemBuilder: (BuildContext context, int index) {
        CoordinateClass coordinates = CoordinateClass.fromLinearIndex(
          index,
          _currentDifficulty.columns,
        );
        MinefieldCell value = _minefield[coordinates.y][coordinates.x];

        return MinesweeperTile(
          coordinates: coordinates,
          cell: value,
          isGameOver: _gameOver,
          isGameWon: _gameOver && _explodedMine == null,
          isExplodedMine:
              _explodedMine != null && _explodedMine!.equals(coordinates),
          onTapTile: _onTapTile,
          onLongPressTile: _onLongPressTile,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalSafeCells =
        (_currentDifficulty.rows * _currentDifficulty.columns) -
        _currentDifficulty.mines;

    return GameContainer(
      title: "Minesweeper",
      startGame: () => _startGame(_currentDifficulty),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: <Widget>[
              MinesweeperControlPanel(
                currentDifficulty: _currentDifficulty,
                switchDifficulty: _switchDifficulty,
              ),
              MinesweeperStatsPanel(
                remainingMines:
                    _currentDifficulty.mines -
                    minesweeperUtils.getPlacedFlags(_minefield),
                revealedCells: _revealedCells,
                totalSafeCells: totalSafeCells,
                elapsedSeconds: _elapsedSeconds,
              ),
              SizedBox(height: 10),
              Expanded(child: _getGrid()),
            ],
          ),
        ),
      ),
    );
  }
}

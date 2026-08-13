import 'package:classic_games/data/coordinate_class.dart';
import 'package:classic_games/data/game_result/fifteen_game_result.dart';
import 'package:classic_games/games/fifteen_game/components/fifteen_game_status_card.dart';
import 'package:classic_games/games/fifteen_game/components/fifteen_game_tile.dart';
import 'package:classic_games/templates/endgame_dialog.dart';
import 'package:classic_games/templates/game_container.dart';
import 'package:classic_games/utils/dialog_utils.dart';
import 'package:classic_games/utils/fifteen_utils.dart';
import 'package:flutter/material.dart';

class FifteenGame extends StatefulWidget {
  const FifteenGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FifteenGameState();
  }
}

class _FifteenGameState extends State<FifteenGame> {
  final DialogUtils dialogUtils = DialogUtils();
  final FifteenUtils fifteenUtils = FifteenUtils();
  final int mapWidth = 4;
  final int mapHeight = 4;
  int _totalMoves = 0;
  bool _isSolved = false;
  List<List<int>> _board = [];

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _board = fifteenUtils.shuffleFifteenBoard(100);
      _isSolved = false;
      _totalMoves = 0;
    });
  }

  void moveTile(CoordinateClass coordinates) {
    if (!_isSolved) {
      List<List<int>> newBoard = fifteenUtils.moveTile(_board, coordinates);
      if (fifteenUtils.hasMoved(newBoard, _board)) {
        setState(() {
          _isSolved = fifteenUtils.isSolved(newBoard);
          _totalMoves++;
          _board = newBoard;
        });
        if (_isSolved) {
          dialogUtils.showEndGameDialog(
            context,
            FifteenGameResult.win,
            <String, String>{"#totalMoves#": _totalMoves.toString()},
            _newGameAction,
          );
        }
      }
    }
  }

  void _newGameAction() {
    Navigator.pop(context);
    _startGame();
  }

  GridView _getGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: mapWidth,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: mapHeight * mapWidth,
      itemBuilder: (BuildContext context, int index) {
        CoordinateClass coordinates = CoordinateClass.fromLinearIndex(
          index,
          mapWidth,
        );
        int value = _board[coordinates.y][coordinates.x];

        return FifteenGameTile(
          text: value != 16 ? value.toString() : "",
          coordinates: coordinates,
          move: moveTile,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      title: "Fifteen Game",
      startGame: _startGame,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: [
              FifteenGameStatusCard(
                isSolved: _isSolved,
                totalMoves: _totalMoves,
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _getGrid(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

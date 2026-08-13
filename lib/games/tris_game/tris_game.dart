import 'package:classic_games/data/game_result/tris_game_result.dart';
import 'package:classic_games/data/tris_actor.dart';
import 'package:classic_games/data/game_result/game_result.dart';
import 'package:classic_games/data/tris_triples.dart';
import 'package:classic_games/games/tris_game/components/tris_game_tile.dart';
import 'package:classic_games/templates/game_container.dart';
import 'package:classic_games/utils/dialog_utils.dart';
import 'package:classic_games/utils/tris_utils.dart';
import 'package:flutter/material.dart';

class TrisGame extends StatefulWidget {
  const TrisGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TrisGameState();
  }
}

class _TrisGameState extends State<TrisGame> {
  final DialogUtils dialogUtils = DialogUtils();
  late TrisActor _currentPlayer;
  late List<TrisActor?> _board;
  bool _isGameOver = false;
  final TrisUtils trisUtils = TrisUtils();
  TrisTriples? _winningTriple;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _board = List.generate(9, (_) => null);
      _currentPlayer = TrisActor.human;
      _isGameOver = false;
      _winningTriple = null;
    });
  }

  void _onCellTapped(int index) {
    if (_board[index] != null ||
        _currentPlayer == TrisActor.cpu ||
        _isGameOver) {
      return;
    }

    _doMove(TrisActor.human, index);
  }

  void _doMove(TrisActor actor, int index) {
    setState(() {
      _board[index] = actor;
    });

    TrisTriples? winningTriple = trisUtils.getWinningTriple(_board, actor);

    if (winningTriple != null) {
      setState(() {
        _isGameOver = true;
        _winningTriple = winningTriple;
      });
      _showEndGameDialog(
        actor == TrisActor.human ? TrisGameResult.win : TrisGameResult.lose,
      );
      return;
    }

    if (trisUtils.allFilled(_board)) {
      setState(() {
        _isGameOver = true;
      });
      _showEndGameDialog(TrisGameResult.even);
      return;
    }

    TrisActor nextPlayer = (actor == TrisActor.human)
        ? TrisActor.cpu
        : TrisActor.human;
    setState(() {
      _currentPlayer = nextPlayer;
    });

    if (nextPlayer == TrisActor.cpu) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted && !_isGameOver) {
          trisUtils.cpuMove(_board, (cpuActor, cpuIndex) {
            _doMove(cpuActor, cpuIndex);
          });
        }
      });
    }
  }

  void _newGameAction() {
    Navigator.pop(context);
    _startGame();
  }

  void _showEndGameDialog(GameResult gameResult) {
    dialogUtils.showEndGameDialog(context, gameResult, null, _newGameAction);
  }

  GridView _getGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        TrisActor? value = _board[index];
        bool isWinningTile =
            _winningTriple != null && _winningTriple!.indexes.contains(index);

        return TrisGameTile(
          actor: value,
          index: index,
          isWinningTile: isWinningTile,
          onCellTapped: _onCellTapped,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      title: "Tris",
      startGame: _startGame,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: AspectRatio(aspectRatio: 1.0, child: _getGrid()),
          ),
        ),
      ),
    );
  }
}

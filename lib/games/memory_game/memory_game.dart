import 'package:classic_games/data/coordinate_class.dart';
import 'package:classic_games/data/memory_difficulty.dart';
import 'package:classic_games/data/memory_theme.dart';
import 'package:classic_games/games/memory_game/components/memory_control_panel.dart';
import 'package:classic_games/games/memory_game/components/memory_game_tile.dart';
import 'package:classic_games/games/memory_game/components/memory_stats_header.dart';
import 'package:classic_games/templates/endgame_dialog.dart';
import 'package:classic_games/templates/game_container.dart';
import 'package:classic_games/utils/dialog_utils.dart';
import 'package:classic_games/utils/memory_utils.dart';
import 'package:flutter/material.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MemoryGameState();
  }
}

class _MemoryGameState extends State<MemoryGame> {
  final DialogUtils dialogUtils = DialogUtils();
  final MemoryUtils memoryUtils = MemoryUtils();
  late List<List<IconData>> _board;

  int _guesses = 0;
  int _matches = 0;

  final Set<IconData> _matched = {};

  MemoryDifficulty _currentDifficulty = MemoryDifficulty.easy;
  MemoryTheme _currentTheme = MemoryTheme.animals;
  CoordinateClass? _firstTurnedCard;
  CoordinateClass? _secondTurnedCard;

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _startGame(_currentDifficulty, _currentTheme);
  }

  void _startGame(MemoryDifficulty difficulty, MemoryTheme theme) {
    setState(() {
      _currentDifficulty = difficulty;
      _currentTheme = theme;
      _guesses = 0;
      _matches = 0;
      _matched.clear();
      _firstTurnedCard = null;
      _secondTurnedCard = null;
      _isProcessing = false;
      _board = memoryUtils.buildBoard(difficulty, theme);
    });
  }

  GridView _getGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _currentDifficulty.cols,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _currentDifficulty.cols * _currentDifficulty.rows,
      itemBuilder: (BuildContext context, int index) {
        CoordinateClass coordinates = CoordinateClass.fromLinearIndex(
          index,
          _currentDifficulty.cols,
        );
        IconData value = _board[coordinates.y][coordinates.x];
        bool isMatched = _matched.contains(value);
        bool isTurned =
            (_firstTurnedCard != null &&
                _firstTurnedCard!.equals(coordinates)) ||
            (_secondTurnedCard != null &&
                _secondTurnedCard!.equals(coordinates));
        return MemoryGameTile(
          icon: value,
          isTurned: isTurned || isMatched,
          isMatched: isMatched,
          themeColor: _currentTheme.themeColor,
          coordinates: coordinates,
          turnCard: turnCard,
        );
      },
    );
  }

  void turnCard(CoordinateClass coordinates) async {
    if (!_canTurnCard(coordinates)) {
      return;
    }

    if (_firstTurnedCard == null) {
      setState(() {
        _firstTurnedCard = coordinates;
      });
      return;
    }

    setState(() {
      _secondTurnedCard = coordinates;
      _guesses++;
      _isProcessing = true;
    });

    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    IconData firstIcon = _board[_firstTurnedCard!.y][_firstTurnedCard!.x];
    IconData secondIcon = _board[_secondTurnedCard!.y][_secondTurnedCard!.x];

    if (firstIcon == secondIcon) {
      setState(() {
        _matched.add(firstIcon);
        _matches++;
      });
    }

    setState(() {
      _firstTurnedCard = null;
      _secondTurnedCard = null;
      _isProcessing = false;
    });

    if (_matches == _currentDifficulty.pairsCount) {
      dialogUtils.showEndGameDialog(
        context,
        EndGameDialog(
          title: "Congratulations!",
          message:
              "You win the game of level ${_currentDifficulty.name} with $_guesses guesses",
          icon: Icons.emoji_events_rounded,
          iconColor: Colors.amber,
          newGameAction: _newGameAction,
        ),
      );
    }
  }

  bool _canTurnCard(CoordinateClass coordinates) {
    bool canTurnCard = true;
    IconData clickedIcon = _board[coordinates.y][coordinates.x];
    if (_isProcessing) {
      canTurnCard = false;
    } else if (_firstTurnedCard != null &&
        _firstTurnedCard!.equals(coordinates)) {
      canTurnCard = false;
    } else if (_matched.contains(clickedIcon)) {
      canTurnCard = false;
    }
    return canTurnCard;
  }

  void _newGameAction() {
    Navigator.pop(context);
    _startGame(_currentDifficulty, _currentTheme);
  }

  void _switchTheme(MemoryTheme newTheme) {
    _startGame(_currentDifficulty, newTheme);
  }

  void _switchDifficulty(MemoryDifficulty newDifficulty) {
    _startGame(newDifficulty, _currentTheme);
  }

  @override
  Widget build(BuildContext context) {
    final double gridAspectRatio =
        _currentDifficulty.cols / _currentDifficulty.rows;

    return GameContainer(
      title: "Memory Game",
      startGame: () => _startGame(_currentDifficulty, _currentTheme),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              MemoryControlPanel(
                currentTheme: _currentTheme,
                currentDifficulty: _currentDifficulty,
                switchTheme: _switchTheme,
                switchDifficulty: _switchDifficulty,
              ),
              const SizedBox(height: 12),
              MemoryStatsHeader(
                guesses: _guesses,
                pairCount: _currentDifficulty.pairsCount,
                matches: _matches,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: gridAspectRatio,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
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

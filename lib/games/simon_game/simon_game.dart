import 'dart:math';

import 'package:classic_games/data/game_result/simon_game_result.dart';
import 'package:classic_games/data/simon_command.dart';
import 'package:classic_games/games/services/audio/simon_audio_service.dart';
import 'package:classic_games/games/simon_game/components/simon_buttons.dart';
import 'package:classic_games/games/simon_game/components/simon_stats_panel.dart';
import 'package:classic_games/templates/game_container.dart';
import 'package:classic_games/utils/dialog_utils.dart';
import 'package:flutter/material.dart';

class SimonGame extends StatefulWidget {
  const SimonGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SimonGameState();
  }
}

class _SimonGameState extends State<SimonGame> {
  final Random _random = Random();
  final DialogUtils _dialogUtils = DialogUtils();
  late final SimonAudioService _audioService;
  final List<SimonCommand> _simonCommands = SimonCommand.values;
  SimonCommand? _currentCommand;
  List<SimonCommand> _commands = [];
  int _executedCommands = 0;
  bool _gameOver = true;
  int _commandIndex = 0;
  bool _isPlayerTurn = false;

  @override
  void initState() {
    super.initState();
    _audioService = SimonAudioService();
    _initAndStart();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  void _initAndStart() async {
    await _audioService.init();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _gameOver = false;
      _commands = [];
      _executedCommands = 0;
      _isPlayerTurn = false;
    });
    _playNewRound();
  }

  void _onTap(SimonCommand command) async {
    if (!_isPlayerTurn || _gameOver) {
      return;
    }

    await _executeCommand(command);

    if (_commands[_commandIndex] == command) {
      setState(() {
        _commandIndex++;
        _currentCommand = null;
      });

      if (_commandIndex > _commands.length - 1) {
        setState(() {
          _isPlayerTurn = false;
          _executedCommands++;
        });
        _playNewRound();
      }
    } else {
      setState(() {
        _gameOver = true;
        _currentCommand = null;
      });
      if (mounted) {
        _dialogUtils.showEndGameDialog(
          context,
          SimonGameResult.lose,
          <String, String>{"#matched#": "$_executedCommands"},
          _newGameAction,
        );
      }
    }
  }

  void _playNewRound() async {
    await Future<void>.delayed(const Duration(seconds: 1), () => {});
    setState(() {
      _commandIndex = 0;
      _commands = [
        ..._commands,
        _simonCommands[_random.nextInt(_simonCommands.length)],
      ];
    });
    for (SimonCommand command in _commands) {
      await _executeCommand(command);
      setState(() {
        _currentCommand = null;
      });
      await Future<void>.delayed(const Duration(milliseconds: 150), () => {});
    }
    setState(() {
      _isPlayerTurn = true;
      _currentCommand = null;
    });
  }

  void _newGameAction() {
    Navigator.pop(context);
    _startGame();
  }

  Future<void> _executeCommand(SimonCommand command) async {
    _audioService.playNote(command);
    setState(() {
      _currentCommand = command;
    });
    await Future<void>.delayed(Duration(milliseconds: 400), () => {});
    _audioService.stopNote();
  }

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      title: "Simon",
      startGame: () => _startGame(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 12),
              SimonStatsPanel(
                currentMove: _commandIndex,
                executedCommands: _executedCommands,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Center(
                  child: SimonButtons(command: _currentCommand, onTap: _onTap),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:classic_games/data/game_result/hangman_game_result.dart';
import 'package:classic_games/data/hangman_category.dart';
import 'package:classic_games/data/hangman_word_repository.dart';
import 'package:classic_games/games/hangman_game/components/hangman_control_panel.dart';
import 'package:classic_games/games/hangman_game/components/hangman_keyboard_letter.dart';
import 'package:classic_games/games/hangman_game/components/hangman_painter_widget.dart';
import 'package:classic_games/games/hangman_game/components/hangman_word_letter.dart';
import 'package:classic_games/templates/game_container.dart';
import 'package:classic_games/utils/dialog_utils.dart';
import 'package:flutter/material.dart';

class HangmanGame extends StatefulWidget {
  const HangmanGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HangmanState();
  }
}

class _HangmanState extends State<HangmanGame> {
  final DialogUtils dialogUtils = DialogUtils();
  late List<String> _word;
  static const List<List<String>> _keyboardRows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];
  HangmanCategory _currentCategory = HangmanCategory.animals;
  int _remainingAttempts = 6;
  late Set<String> _errors;
  late Set<String> _matches;
  late Set<String> _wordSet;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _word = HangmanWordRepository.getRandomWord(_currentCategory).split('');
      _errors = {};
      _matches = {};
      _wordSet = _word.toSet();
      _remainingAttempts = 6;
    });
  }

  void _onLetterTap(String letter) {
    if (_matches.contains(letter) ||
        _errors.contains(letter) ||
        _remainingAttempts < 1) {
      return;
    }

    if (_wordSet.contains(letter)) {
      Set<String> newMatches = {..._matches};
      newMatches.add(letter);

      setState(() {
        _matches = newMatches;
      });

      if (_matches.containsAll(_wordSet)) {
        _showDialog(HangmanGameResult.win);
      }
    } else {
      Set<String> newErrors = {..._errors};
      newErrors.add(letter);

      setState(() {
        _errors = newErrors;
        _remainingAttempts--;
      });

      if (_remainingAttempts < 1) {
        _showDialog(HangmanGameResult.lose);
      }
    }
  }

  void _newGameAction() {
    Navigator.pop(context);
    _startGame();
  }

  void _switchCategory(HangmanCategory newCategory) {
    setState(() {
      _currentCategory = newCategory;
    });
    _startGame();
  }

  void _showDialog(HangmanGameResult gameResult) {
    dialogUtils.showEndGameDialog(context, gameResult, <String, String>{
      "#word#": _word.join().toUpperCase(),
      "#remainingAttempts#": _remainingAttempts.toString(),
    }, _newGameAction);
  }

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      title: "Hangman",
      startGame: _startGame,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HangmanControlPanel(
              currentCategory: _currentCategory,
              switchCategory: _switchCategory,
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                _currentCategory.message,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 12),
            HangmanPainterWidget(remainingAttempts: _remainingAttempts),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _word
                  .map(
                    (String letter) => HangmanWordLetter(
                      letter: letter,
                      isMatched: _matches.contains(letter),
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: _keyboardRows.map((row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((letter) {
                        return HangmanKeyboardLetter(
                          letter: letter,
                          isError: _errors.contains(letter),
                          isMatched: _matches.contains(letter),
                          onLetterTap: _onLetterTap,
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

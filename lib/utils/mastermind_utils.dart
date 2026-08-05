import 'dart:math';

import 'package:classic_games/data/mastermind_color.dart';
import 'package:flutter/material.dart';

class MastermindUtils {
  List<MastermindColor> getSecretCombination() {
    List<MastermindColor> board = [];
    Random random = Random();
    for (int i = 0; i < 4; i++) {
      board.add(
        MastermindColor.values[random.nextInt(MastermindColor.values.length)],
      );
    }
    return board;
  }

  List<Color> attemptCombination(
    List<MastermindColor?> currentCombination,
    List<MastermindColor> secretCombination,
  ) {
    List<Color> attemptResult = [];
    Map<MastermindColor?, int> unmatchedGuess = {};
    Map<MastermindColor, int> unmatchedSecret = {};

    for (int i = 0; i < currentCombination.length; i++) {
      if (currentCombination[i] == secretCombination[i]) {
        attemptResult.add(Colors.black);
      } else {
        unmatchedSecret.update(
          secretCombination[i],
          (value) => value + 1,
          ifAbsent: () => 1,
        );
        unmatchedGuess.update(
          currentCombination[i],
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    }

    if (attemptResult.length != currentCombination.length) {
      List<Color> positionalMistakes = _getPositionalMistakes(
        unmatchedGuess,
        unmatchedSecret,
      );
      attemptResult.addAll(positionalMistakes);
    }

    return attemptResult;
  }

  List<Color> _getPositionalMistakes(
    Map<MastermindColor?, int> unmatchedGuess,
    Map<MastermindColor, int> unmatchedSecret,
  ) {
    List<Color> positionalMistakes = [];
    for (MapEntry<MastermindColor?, int> entry in unmatchedGuess.entries) {
      if (unmatchedSecret.containsKey(entry.key)) {
        int seenInSecret = unmatchedSecret[entry.key]!;
        int seenInGuess = entry.value;
        int occurrences = min(seenInSecret, seenInGuess);
        for (int i = 0; i < occurrences; i++) {
          positionalMistakes.add(Colors.white);
        }
      }
    }
    return positionalMistakes;
  }
}

import 'package:classic_games/data/memory_difficulty.dart';
import 'package:classic_games/data/memory_theme.dart';
import 'package:flutter/material.dart';

class MemoryUtils {
  List<List<IconData>> buildBoard(
    MemoryDifficulty difficulty,
    MemoryTheme theme,
  ) {
    List<List<IconData>> board = [];
    List<IconData> icons = theme.getCardsForPairs(difficulty.pairsCount);

    for (int row = 0; row < difficulty.rows; row++) {
      List<IconData> boardRow = [];
      for (int col = 0; col < difficulty.cols; col++) {
        boardRow.add(icons[row * difficulty.cols + col]);
      }
      board.add(boardRow);
    }
    return board;
  }
}

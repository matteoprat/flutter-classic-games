import 'package:classic_games/data/hanoi_tower_move.dart';
import 'package:classic_games/data/hanoi_tower_move_validation.dart';

class HanoiTowerUtils {
  List<List<int?>> getStartingBoard(int discs) {
    List<List<int?>> startingBoard = [];

    for (int i = 0; i < 3; i++) {
      bool isBoardNull = i != 0;
      List<int?> boardColumn = [];

      for (int j = 0; j < discs; j++) {
        boardColumn.add(isBoardNull ? null : discs - 1 - j);
      }

      startingBoard.add(boardColumn);
    }

    return startingBoard;
  }

  HanoiTowerMoveValidation isValidMove(
    HanoiTowerMove move,
    List<List<int?>> currentBoard,
    int discs,
  ) {
    int? newColumnCurrentValue;

    for (int i = discs - 1; i >= 0; i--) {
      if (currentBoard[move.targetColumn][i] != null) {
        newColumnCurrentValue = currentBoard[move.targetColumn][i];
        break;
      }
    }

    int? newColumnIndex = currentBoard[move.targetColumn].indexWhere(
      (int? element) => element == null,
    );

    bool isValid =
        newColumnIndex >= 0 &&
        (newColumnCurrentValue == null || newColumnCurrentValue > move.value);

    return HanoiTowerMoveValidation(
      isValid: isValid,
      newColumnIndex: newColumnIndex,
    );
  }

  bool isWinningBoard(List<List<int?>> board) {
    return board[2].every((int? element) => element != null);
  }
}

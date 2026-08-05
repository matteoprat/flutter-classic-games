import 'dart:math';

import 'package:classic_games/data/coordinate_class.dart';
import 'package:classic_games/data/move_direction.dart';

class FifteenUtils {
  final int _maxX = 3;
  final int _maxY = 3;
  final int _minX = 0;
  final int _minY = 0;
  final int _cursorValue = 16;

  final List<List<int>> _solution = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 16],
  ];

  final Map<MoveDirection, CoordinateClass> moves = {
    MoveDirection.up: CoordinateClass(x: 0, y: -1),
    MoveDirection.down: CoordinateClass(x: 0, y: 1),
    MoveDirection.right: CoordinateClass(x: 1, y: 0),
    MoveDirection.left: CoordinateClass(x: -1, y: 0),
  };

  final Map<MoveDirection, MoveDirection> oppositeMoves = {
    MoveDirection.up: MoveDirection.down,
    MoveDirection.down: MoveDirection.up,
    MoveDirection.right: MoveDirection.left,
    MoveDirection.left: MoveDirection.right,
  };

  List<List<int>> shuffleFifteenBoard(int shuffles) {
    List<List<int>> board = _solution
        .map((subList) => List<int>.from(subList))
        .toList();
    int i = 0;
    CoordinateClass coordinates = CoordinateClass(x: 3, y: 3);
    MoveDirection lastMove = MoveDirection.down;

    final Random random = Random();

    while (i < shuffles) {
      List<MapEntry<MoveDirection, CoordinateClass>> validMoves = [];

      for (MapEntry<MoveDirection, CoordinateClass> move in moves.entries) {
        if (oppositeMoves[move.key] != lastMove &&
            isValidMove(coordinates, move.value)) {
          validMoves.add(move);
        }
      }

      int pickedMove = random.nextInt(validMoves.length);
      CoordinateClass coordinatesModifier = validMoves[pickedMove].value;
      CoordinateClass newCoordinates = CoordinateClass(
        x: coordinates.x + coordinatesModifier.x,
        y: coordinates.y + coordinatesModifier.y,
      );

      int oldCurrent = board[coordinates.y][coordinates.x];
      int newCurrent = board[newCoordinates.y][newCoordinates.x];

      board[coordinates.y][coordinates.x] = newCurrent;
      board[newCoordinates.y][newCoordinates.x] = oldCurrent;

      coordinates = newCoordinates;
      lastMove = validMoves[pickedMove].key;
      i++;
    }
    return board;
  }

  bool isValidMove(
    CoordinateClass currentCoordinates,
    CoordinateClass coordinatesModifier,
  ) {
    int newX = currentCoordinates.x + coordinatesModifier.x;
    int newY = currentCoordinates.y + coordinatesModifier.y;
    return isExistingTile(newX, newY);
  }

  bool isExistingTile(int x, int y) {
    return x >= _minX && x <= _maxX && y >= _minY && y <= _maxY;
  }

  List<List<int>> moveTile(
    List<List<int>> currentBoard,
    CoordinateClass coordinates,
  ) {
    List<List<int>> board = currentBoard
        .map((subList) => List<int>.from(subList))
        .toList();

    for (MapEntry<MoveDirection, CoordinateClass> move in moves.entries) {
      int newX = coordinates.x + move.value.x;
      int newY = coordinates.y + move.value.y;

      if (isExistingTile(newX, newY) && board[newY][newX] == _cursorValue) {
        int oldCurrent = board[coordinates.y][coordinates.x];
        int newCurrent = board[newY][newX];

        board[coordinates.y][coordinates.x] = newCurrent;
        board[newY][newX] = oldCurrent;

        break;
      }
    }
    return board;
  }

  bool isSolved(List<List<int>> board) {
    for (int i = 0; i <= _maxY; i++) {
      for (int j = 0; j <= _maxX; j++) {
        if (board[i][j] != _solution[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  bool hasMoved(List<List<int>> board, List<List<int>> previousBoard) {
    for (int i = 0; i <= _maxY; i++) {
      for (int j = 0; j <= _maxX; j++) {
        if (board[i][j] != previousBoard[i][j]) {
          return true;
        }
      }
    }
    return false;
  }
}

import 'dart:math';

import 'package:classic_games/data/coordinate_class.dart';
import 'package:classic_games/data/minefield_cell.dart';
import 'package:classic_games/data/minesweeper_difficulty.dart';

class MinesweeperUtils {
  static final Random _random = Random();
  static final List<CoordinateClass> adjacenceModifiers = [
    CoordinateClass(x: -1, y: -1),
    CoordinateClass(x: 0, y: -1),
    CoordinateClass(x: 1, y: -1),
    CoordinateClass(x: -1, y: 0),
    CoordinateClass(x: 1, y: 0),
    CoordinateClass(x: -1, y: 1),
    CoordinateClass(x: 0, y: 1),
    CoordinateClass(x: 1, y: 1),
  ];

  List<List<MinefieldCell>> populateMineField(
    List<List<MinefieldCell>> minefield,
    MinesweeperDifficulty difficulty,
    CoordinateClass coordinates,
  ) {
    placeMinesOnNewMineField(minefield, coordinates, difficulty);
    calculateAllAdjacencies(minefield, difficulty);

    return minefield;
  }

  void placeMinesOnNewMineField(
    List<List<MinefieldCell>> minefield,
    CoordinateClass coordinates,
    MinesweeperDifficulty difficulty,
  ) {
    int placedMines = 0;
    while (placedMines < difficulty.mines) {
      {
        int index = _random.nextInt(difficulty.columns * difficulty.rows);
        CoordinateClass currentCoordinates = CoordinateClass.fromLinearIndex(
          index,
          difficulty.columns,
        );
        if (canPlaceMine(
          currentCoordinates,
          coordinates,
          minefield[currentCoordinates.y][currentCoordinates.x].isMine,
        )) {
          minefield[currentCoordinates.y][currentCoordinates.x].isMine = true;
          placedMines++;
        }
      }
    }
  }

  bool canPlaceMine(
    CoordinateClass currentCoordinates,
    CoordinateClass startCoordinates,
    bool isAlreadyMine,
  ) {
    bool canPlaceMine = true;
    bool isStartOrNear =
        (currentCoordinates.x - startCoordinates.x).abs() <= 1 &&
        (currentCoordinates.y - startCoordinates.y).abs() <= 1;
    if (isAlreadyMine) {
      canPlaceMine = false;
    } else if (isStartOrNear) {
      canPlaceMine = false;
    }
    return canPlaceMine;
  }

  void calculateAllAdjacencies(
    List<List<MinefieldCell>> minefield,
    MinesweeperDifficulty difficulty,
  ) {
    int maxCol = difficulty.columns - 1;
    int maxRow = difficulty.rows - 1;

    for (int row = 0; row <= maxRow; row++) {
      for (int column = 0; column <= maxCol; column++) {
        if (!minefield[row][column].isMine) {
          int mines = countAdjacenses(
            minefield,
            difficulty,
            CoordinateClass(x: column, y: row),
          );
          minefield[row][column].adjacentMines = mines;
        }
      }
    }
  }

  int countAdjacenses(
    List<List<MinefieldCell>> minefield,
    MinesweeperDifficulty difficulty,
    CoordinateClass coordinates,
  ) {
    int minCol = 0;
    int maxCol = difficulty.columns - 1;
    int minRow = 0;
    int maxRow = difficulty.rows - 1;
    int mines = 0;
    for (CoordinateClass modifier in adjacenceModifiers) {
      if (coordinates.x + modifier.x >= minCol &&
          coordinates.x + modifier.x <= maxCol &&
          coordinates.y + modifier.y >= minRow &&
          coordinates.y + modifier.y <= maxRow) {
        if (minefield[coordinates.y + modifier.y][coordinates.x + modifier.x]
            .isMine) {
          mines++;
        }
      }
    }
    return mines;
  }

  int revealCell(
    List<List<MinefieldCell>> minefield,
    MinesweeperDifficulty difficulty,
    CoordinateClass coordinates,
  ) {
    Set<int> revealed = _recursiveReveal(
      minefield,
      difficulty,
      coordinates,
      <int>{},
    );
    return revealed.length;
  }

  Set<int> _recursiveReveal(
    List<List<MinefieldCell>> minefield,
    MinesweeperDifficulty difficulty,
    CoordinateClass coordinates,
    Set<int> revealed,
  ) {
    if (coordinates.x < 0 ||
        coordinates.x >= difficulty.columns ||
        coordinates.y < 0 ||
        coordinates.y >= difficulty.rows) {
      return revealed;
    } else if (revealed.contains(
      (coordinates.toLinearIndex(difficulty.columns)),
    )) {
      return revealed;
    }

    MinefieldCell cell = minefield[coordinates.y][coordinates.x];
    if (cell.isRevealed || cell.isFlagged || cell.isMine) {
      return revealed;
    }
    revealed.add(coordinates.toLinearIndex(difficulty.columns));
    cell.isRevealed = true;

    if (cell.adjacentMines == 0) {
      for (CoordinateClass modifier in adjacenceModifiers) {
        _recursiveReveal(
          minefield,
          difficulty,
          CoordinateClass(
            x: coordinates.x + modifier.x,
            y: coordinates.y + modifier.y,
          ),
          revealed,
        );
      }
    }
    return revealed;
  }

  int getPlacedFlags(List<List<MinefieldCell>> minefield) {
    int count = 0;
    for (List<MinefieldCell> row in minefield) {
      for (MinefieldCell cell in row) {
        if (cell.isFlagged) {
          count++;
        }
      }
    }
    return count;
  }
}

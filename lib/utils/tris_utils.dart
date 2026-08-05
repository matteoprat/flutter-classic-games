import 'dart:math';

import 'package:classic_games/data/tris_actor.dart';
import 'package:classic_games/data/tris_triples.dart';

class TrisUtils {
  final Random random = Random();

  TrisTriples? getWinningTriple(List<TrisActor?> board, TrisActor actor) {
    for (TrisTriples triple in TrisTriples.values) {
      if (triple.indexes.every((int index) => board[index] == actor)) {
        return triple;
      }
    }
    return null;
  }

  bool allFilled(List<TrisActor?> board) {
    return !board.any((TrisActor? element) => element == null);
  }

  bool canMove(int index, List<TrisActor?> board) {
    return board[index] == null;
  }

  void cpuMove(
    List<TrisActor?> board,
    void Function(TrisActor actor, int index) doMove,
  ) {
    int nextMove = tryToWin(board);
    if (nextMove == -1) {
      nextMove = tryToStop(board);
    }
    if (nextMove == -1) {
      nextMove = getRandomMove(board);
    }
    doMove(TrisActor.cpu, nextMove);
  }

  int tryToWin(List<TrisActor?> board) {
    return tryMove(board, TrisActor.cpu);
  }

  int tryToStop(List<TrisActor?> board) {
    return tryMove(board, TrisActor.human);
  }

  int tryMove(List<TrisActor?> board, TrisActor actor) {
    for (TrisTriples triple in TrisTriples.values) {
      int actorCount = 0;
      int emptyIndex = -1;

      for (int index in triple.indexes) {
        if (board[index] == actor) {
          actorCount++;
        } else if (board[index] == null) {
          emptyIndex = index;
        }
      }

      if (actorCount == 2 && emptyIndex != -1) {
        return emptyIndex;
      }
    }
    return -1;
  }

  int getRandomMove(List<TrisActor?> board) {
    List<int> emptyIndices = [];
    int nextMove = 0;
    for (int i = 0; i < board.length; i++) {
      if (board[i] == null) {
        emptyIndices.add(i);
      }
    }
    if (emptyIndices.isNotEmpty) {
      nextMove = emptyIndices[random.nextInt(emptyIndices.length)];
    }
    return nextMove;
  }
}

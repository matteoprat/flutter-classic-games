import 'package:classic_games/data/coordinate_class.dart';
import 'package:classic_games/data/minefield_cell.dart';
import 'package:flutter/material.dart';

class MinesweeperTile extends StatelessWidget {
  final CoordinateClass coordinates;
  final MinefieldCell cell;
  final bool isGameOver;
  final bool isGameWon;
  final bool isExplodedMine;
  final Function(CoordinateClass coordinates) onTapTile;
  final Function(CoordinateClass coordinates) onLongPressTile;

  const MinesweeperTile({
    super.key,
    required this.coordinates,
    required this.cell,
    required this.onTapTile,
    required this.onLongPressTile,
    required this.isGameOver,
    required this.isGameWon,
    required this.isExplodedMine,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;

    if (isExplodedMine) {
      backgroundColor = Colors.redAccent;
    } else if (cell.isRevealed) {
      backgroundColor = Colors.grey[200]!;
    } else {
      backgroundColor = Colors.grey[400]!;
    }

    return GestureDetector(
      onTap: (isGameOver || cell.isRevealed || cell.isFlagged)
          ? null
          : () => onTapTile(coordinates),
      onLongPress: (isGameOver || cell.isRevealed)
          ? null
          : () => onLongPressTile(coordinates),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: cell.isRevealed ? Colors.grey[300]! : Colors.grey[500]!,
            width: cell.isRevealed ? 1.0 : 1.5,
          ),
          boxShadow: cell.isRevealed
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: _MineSweeperTileContent(
            cell: cell,
            shouldShowIcon: cell.isRevealed || isGameOver,
            isGameOver: isGameOver,
          ),
        ),
      ),
    );
  }
}

class _MineSweeperTileContent extends StatelessWidget {
  static const List<Color> _colors = <Color>[
    Colors.transparent,
    Color(0xFF0000FF),
    Color(0xFF008000),
    Color(0xFFFF0000),
    Color(0xFF000080),
    Color(0xFF800000),
    Color(0xFF008080),
    Color(0xFF000000),
    Color(0xFF808080),
  ];

  final MinefieldCell cell;
  final bool shouldShowIcon;
  final bool isGameOver;

  const _MineSweeperTileContent({
    required this.cell,
    required this.shouldShowIcon,
    required this.isGameOver,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = SizedBox.shrink();

    if (!shouldShowIcon && !cell.isFlagged) {
      widget = SizedBox.shrink();
    } else if (cell.isFlagged) {
      widget = Icon(
        isGameOver && !cell.isMine
            ? Icons.flag_circle_rounded
            : Icons.flag_rounded,
        size: 18,
        color: Colors.red,
      );
    } else if (shouldShowIcon && cell.isMine) {
      widget = Icon(Icons.brightness_7_rounded, size: 18, color: Colors.black);
    } else if (shouldShowIcon && cell.adjacentMines > 0) {
      widget = Text(
        cell.adjacentMines.toString(),
        style: TextStyle(
          color: _colors[cell.adjacentMines],
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return widget;
  }
}

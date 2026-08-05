import 'package:classic_games/data/tris_actor.dart';
import 'package:flutter/material.dart';

class TrisGameTile extends StatelessWidget {
  final TrisActor? actor;
  final int index;
  final bool isWinningTile;
  final Function(int index) onCellTapped;

  const TrisGameTile({
    super.key,
    this.actor,
    required this.index,
    required this.isWinningTile,
    required this.onCellTapped,
  });

  @override
  Widget build(BuildContext context) {
    bool isEmpty = actor == null;
    return GestureDetector(
      onTap: () => onCellTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: isWinningTile ? Colors.green[100] : Colors.white,
          border: Border.all(
            color: isWinningTile ? Colors.green[700]! : Colors.black54,
            width: isWinningTile ? 3.0 : 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
          boxShadow: [
            BoxShadow(
              color: isWinningTile
                  ? Colors.green.withValues(alpha: 0.3)
                  : Colors.black12,
              blurRadius: isWinningTile ? 8 : 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: isEmpty
            ? null
            : Icon(actor!.icon, size: 56, color: actor!.color),
      ),
    );
  }
}

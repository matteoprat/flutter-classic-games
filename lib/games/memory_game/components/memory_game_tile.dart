import 'package:classic_games/data/coordinate_class.dart';
import 'package:flutter/material.dart';

class MemoryGameTile extends StatelessWidget {
  final IconData icon;
  final bool isTurned;
  final bool isMatched;
  final Color themeColor;
  final CoordinateClass coordinates;
  final Function(CoordinateClass) turnCard;

  const MemoryGameTile({
    super.key,
    required this.icon,
    required this.isTurned,
    required this.isMatched,
    required this.themeColor,
    required this.coordinates,
    required this.turnCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => turnCard(coordinates),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: isMatched
              ? Colors.green.withValues(alpha: 0.15)
              : (isTurned ? Colors.white : themeColor),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isMatched
                ? Colors.green
                : (isTurned ? themeColor : Colors.white.withValues(alpha: 0.3)),
            width: isMatched || isTurned ? 2.5 : 1.0,
          ),
          boxShadow: isTurned
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: themeColor.withValues(alpha: 0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: isTurned
              ? Icon(
                  icon,
                  key: ValueKey('icon_${icon.codePoint}'),
                  size: 32,
                  color: isMatched ? Colors.green[700] : themeColor,
                )
              : Icon(
                  Icons.question_mark_rounded,
                  key: const ValueKey('question_mark'),
                  size: 22,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
        ),
      ),
    );
  }
}

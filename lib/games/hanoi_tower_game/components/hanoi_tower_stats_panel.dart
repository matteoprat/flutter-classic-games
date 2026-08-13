import 'package:classic_games/templates/state_item.dart';
import 'package:flutter/material.dart';

class HanoiTowerStatsPanel extends StatelessWidget {
  final int totalMoves;
  final int perfectScore;

  const HanoiTowerStatsPanel({
    super.key,
    required this.totalMoves,
    required this.perfectScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StateItem(
            icon: Icons.swap_horiz_rounded,
            iconColor: Colors.blueAccent,
            label: "Swaps: $totalMoves",
          ),
          StateItem(
            icon: Icons.star_outline_rounded,
            iconColor: Colors.amberAccent,
            label: "Perfect swaps: $perfectScore",
          ),
        ],
      ),
    );
  }
}

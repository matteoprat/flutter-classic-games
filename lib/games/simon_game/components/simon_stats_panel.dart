import 'package:classic_games/templates/state_item.dart';
import 'package:flutter/material.dart';

class SimonStatsPanel extends StatelessWidget {
  final int currentMove;
  final int executedCommands;

  const SimonStatsPanel({
    super.key,
    required this.currentMove,
    required this.executedCommands,
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
            icon: Icons.check,
            iconColor: Colors.green,
            label: "Matches: $currentMove",
          ),
          StateItem(
            icon: Icons.done_all_rounded,
            iconColor: Colors.purple,
            label: "Sequences matched: $executedCommands",
          ),
        ],
      ),
    );
  }
}

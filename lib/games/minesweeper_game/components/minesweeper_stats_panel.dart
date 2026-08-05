import 'package:flutter/material.dart';

class MinesweeperStatsPanel extends StatelessWidget {
  final int remainingMines;
  final int revealedCells;
  final int totalSafeCells;
  final int elapsedSeconds;

  const MinesweeperStatsPanel({
    super.key,
    required this.remainingMines,
    required this.revealedCells,
    required this.totalSafeCells,
    required this.elapsedSeconds,
  });

  String _formaTime(int seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

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
          _StateItem(
            icon: Icons.flag_rounded,
            iconColor: Colors.redAccent,
            label: "$remainingMines",
          ),
          _StateItem(
            icon: Icons.grid_on_rounded,
            iconColor: Colors.blueAccent,
            label: "$revealedCells / $totalSafeCells",
          ),
          _StateItem(
            icon: Icons.timer_rounded,
            iconColor: Colors.orangeAccent,
            label: _formaTime(elapsedSeconds),
          ),
        ],
      ),
    );
  }
}

class _StateItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const _StateItem({
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

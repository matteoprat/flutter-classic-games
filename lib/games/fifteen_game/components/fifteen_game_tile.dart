import 'package:classic_games/data/coordinate_class.dart';
import 'package:flutter/material.dart';

class FifteenGameTile extends StatelessWidget {
  final Function move;
  final String text;
  final CoordinateClass coordinates;

  const FifteenGameTile({
    super.key,
    required this.text,
    required this.coordinates,
    required this.move,
  });
  @override
  Widget build(BuildContext context) {
    bool isEmpty = text.isEmpty;

    return GestureDetector(
      onTap: () => move(coordinates),
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: isEmpty ? Colors.transparent : Colors.white,
          border: isEmpty
              ? null
              : Border.all(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: isEmpty
              ? []
              : [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

import 'package:classic_games/data/coordinate_class.dart';
import 'package:classic_games/data/hanoi_tower_move.dart';
import 'package:flutter/material.dart';

class HanoiTowerDisc extends StatelessWidget {
  final int? size;
  final int discs;
  final bool isDraggable;
  final CoordinateClass coordinates;

  const HanoiTowerDisc({
    super.key,
    this.size,
    required this.discs,
    required this.isDraggable,
    required this.coordinates,
  });

  static final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.indigo,
  ];

  Container _getEmptyContainer() {
    return Container(width: 5, height: 20, color: Colors.brown);
  }

  Container _getDisc() {
    return Container(
      width: 20 * (size! + 1),
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: colors[size! % colors.length],
      ),
    );
  }

  Widget _getWidget() {
    Widget content;
    if (size == null) {
      content = _getEmptyContainer();
    } else if (isDraggable) {
      content = Draggable<HanoiTowerMove>(
        data: HanoiTowerMove(
          currentCoordinates: coordinates,
          targetColumn: -1,
          value: size!,
        ),
        feedback: Material(color: Colors.transparent, child: _getDisc()),
        childWhenDragging: _getEmptyContainer(),
        child: _getDisc(),
      );
    } else {
      content = Container(
        width: 20 * (size! + 1),
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: colors[size!],
        ),
      );
    }
    return SizedBox(
      width: 20.0 * discs,
      height: 20,
      child: Center(child: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: _getWidget(),
    );
  }
}

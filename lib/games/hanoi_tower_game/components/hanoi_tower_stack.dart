import 'package:classic_games/data/coordinate_class.dart';
import 'package:classic_games/data/hanoi_tower_move.dart';
import 'package:classic_games/games/hanoi_tower_game/components/hanoi_tower_disc.dart';
import 'package:flutter/material.dart';

class HanoiTowerStack extends StatelessWidget {
  final List<int?> stack;
  final String label;
  final int discs;
  final int columnIndex;
  final Function(HanoiTowerMove) doMove;

  const HanoiTowerStack({
    super.key,
    required this.stack,
    required this.label,
    required this.discs,
    required this.columnIndex,
    required this.doMove,
  });

  @override
  Widget build(BuildContext context) {
    final int topDiscArrayIndex = stack.lastIndexWhere(
      (int? value) => value != null,
    );

    final double stackWidth = 20.0 * discs;

    return Column(
      children: <Widget>[
        DragTarget<HanoiTowerMove>(
          builder:
              (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return SizedBox(
                  width: stackWidth + 20.0,
                  child: Column(
                    children: [
                      Container(width: 5, height: 10, color: Colors.brown),
                      ...List.generate(discs, (int uiIndex) {
                        final int arrayIndex = discs - 1 - uiIndex;
                        final int? size = stack[arrayIndex];
                        return HanoiTowerDisc(
                          size: size,
                          discs: discs,
                          isDraggable: arrayIndex == topDiscArrayIndex,
                          coordinates: CoordinateClass(
                            x: columnIndex,
                            y: arrayIndex,
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
          onAcceptWithDetails: (DragTargetDetails<HanoiTowerMove> details) {
            doMove(details.data.copyWith(targetColumn: columnIndex));
          },
        ),
        Container(
          width: stackWidth + 20.0,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.brown[800],
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}

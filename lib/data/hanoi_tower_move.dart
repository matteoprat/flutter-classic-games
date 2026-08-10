import 'package:classic_games/data/coordinate_class.dart';

class HanoiTowerMove {
  final CoordinateClass currentCoordinates;
  final int targetColumn;
  final int value;

  const HanoiTowerMove({
    required this.currentCoordinates,
    required this.targetColumn,
    required this.value,
  });

  HanoiTowerMove copyWith({
    CoordinateClass? currentCoordinates,
    int? targetColumn,
    int? value,
  }) {
    return HanoiTowerMove(
      currentCoordinates: currentCoordinates ?? this.currentCoordinates,
      targetColumn: targetColumn ?? this.targetColumn,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return "HanoiTowerMove: {currentCoordinates: $currentCoordinates, targetColumn: $targetColumn, value: $value}";
  }
}

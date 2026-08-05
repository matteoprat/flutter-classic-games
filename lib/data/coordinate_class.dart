class CoordinateClass {
  final int x;
  final int y;

  CoordinateClass({required this.x, required this.y});

  @override
  String toString() {
    return "x: $x, y: $y";
  }

  static CoordinateClass fromLinearIndex(int index, int columns) {
    int row = index ~/ columns;
    int column = index % columns;
    return CoordinateClass(x: column, y: row);
  }

  bool equals(CoordinateClass other) {
    return x == other.x && y == other.y;
  }

  int toLinearIndex(int columns) {
    return (y * columns) + x;
  }
}

enum MemoryDifficulty {
  easy(rows: 4, cols: 3, pairsCount: 6),
  medium(rows: 4, cols: 4, pairsCount: 8),
  hard(rows: 5, cols: 4, pairsCount: 10);

  final int rows;
  final int cols;
  final int pairsCount;

  const MemoryDifficulty({
    required this.rows,
    required this.cols,
    required this.pairsCount,
  });
}

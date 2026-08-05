enum TrisTriples {
  h1(indexes: [0, 1, 2]),
  h2(indexes: [3, 4, 5]),
  h3(indexes: [6, 7, 8]),
  v1(indexes: [0, 3, 6]),
  v2(indexes: [1, 4, 7]),
  v3(indexes: [2, 5, 8]),
  d1(indexes: [0, 4, 8]),
  d2(indexes: [2, 4, 6]);

  final List<int> indexes;

  const TrisTriples({required this.indexes});
}

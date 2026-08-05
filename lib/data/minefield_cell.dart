class MinefieldCell {
  bool isMine;
  bool isFlagged;
  bool isRevealed;
  int adjacentMines;

  MinefieldCell({
    this.isMine = false,
    this.isFlagged = false,
    this.isRevealed = false,
    this.adjacentMines = 0,
  });

  void toggleFlag() {
    if (!isRevealed) {
      isFlagged = !isFlagged;
    }
  }

  void reset() {
    isMine = false;
    isFlagged = false;
    isRevealed = false;
    adjacentMines = 0;
  }
}

class HangmanUtils {
  List<int> findIndexes(List<String> word, String letter) {
    List<int> indexes = [];
    for (int i = 0; i < word.length; i++) {
      if (word[i] == letter) {
        indexes.add(i);
      }
    }
    return indexes;
  }
}

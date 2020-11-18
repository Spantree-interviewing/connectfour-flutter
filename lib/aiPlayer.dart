class AiPlayer {
  List<int> _columns = [0, 1, 2, 3, 4, 5, 6];
  int playRound() {
    _columns.shuffle();
    return _columns[0];
  }
}

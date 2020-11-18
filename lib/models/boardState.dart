class BoardState {
  int location;
  String player;

  BoardState({this.location, this.player});

  bool isOccupied() {
    return player != null;
  }
}

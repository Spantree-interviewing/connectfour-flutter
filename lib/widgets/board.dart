import 'package:connect_four/aiPlayer.dart';
import 'package:connect_four/models/boardState.dart';
import 'package:connect_four/widgets/boardItem.dart';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  final List<BoardState> boardStates;

  const Board({Key key, this.boardStates}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Widget> items;
  AiPlayer aiPlayer = AiPlayer();

  @override
  void initState() {
    setState(() {
      items = _buildGridItems(widget.boardStates);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
                child: new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0),
                    itemCount: items.length,
                    itemBuilder: (_, i) => GestureDetector(
                          onTap: () {
                            var available = _nextAvailableSlot(i);
                            if (available >= 0) {
                              setState(() {
                                var bState =
                                    BoardState(location: i, player: "Human");
                                items[available] =
                                    BoardItem(boardState: bState);
                                widget.boardStates[available].player = "Human";
                              });
                            }

                            //AI Turn now
                            var takeTurn = true;
                            var invalidCols = [];
                            while (takeTurn) {
                              var col = aiPlayer.playRound();
                              var available = _nextAvailableSlot(col);
                              if (available >= 0 &&
                                  !invalidCols.contains(available)) {
                                print("ai plays: $available");
                                setState(() {
                                  var bState = BoardState(
                                      location: available, player: "AI");
                                  items[available] =
                                      BoardItem(boardState: bState);
                                  widget.boardStates[available].player = "AI";
                                });
                                takeTurn = false;
                              }
                              invalidCols.add(available);
                              if (invalidCols.length == 7) {
                                takeTurn = false;
                              }
                            }
                          },
                          child: items[i],
                        )))
          ]),
    );
  }

  List<Widget> _buildGridItems(List<BoardState> boardStates) {
    return boardStates.map((b) {
      return _buildGridItem(b);
    }).toList();
  }

  Widget _buildGridItem(BoardState boardState) {
    return BoardItem(
      boardState: boardState,
      onSelect: () {
        print("selected: ${boardState.player} : ${boardState.location}");
      },
    );
  }

  int _nextAvailableSlot(int col) {
    var it = col + 35;
    while (it > col) {
      if (!widget.boardStates[it].isOccupied()) {
        return it;
      }
      it = it - 7;
    }

    if (!widget.boardStates[col].isOccupied()) {
      return col;
    }

    return -1;
  }
}

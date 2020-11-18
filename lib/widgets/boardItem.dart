import 'package:connect_four/models/boardState.dart';
import 'package:flutter/material.dart';

class BoardItem extends StatefulWidget {
  final BoardState boardState;
  final void Function() onSelect;

  const BoardItem({Key key, this.boardState, this.onSelect}) : super(key: key);

  @override
  _BoardItemState createState() => _BoardItemState();
}

class _BoardItemState extends State<BoardItem> {
  var color = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    switch (widget.boardState.player) {
      case "Human":
        color = Colors.red;
        break;
      case "AI":
        color = Colors.black;
        break;
      default:
        color = Colors.transparent;
    }
    return SizedBox(
        width: 100,
        height: 100,
        child: Material(elevation: 4.0, shape: CircleBorder(), color: color));
  }
}

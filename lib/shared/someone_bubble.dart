import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class SomeoneBubble extends StatelessWidget {
  const SomeoneBubble({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 4, bottom: 2),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Author',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ),
        ),
        Bubble(
          style: BubbleStyle(
            nip: BubbleNip.leftBottom,
            color: Colors.white,
            margin: BubbleEdges.only(top: 0.0, right: 50.0, bottom: 8, left: 4),
            alignment: Alignment.topLeft,
          ),
          child: Text('sample text'),
        ),
      ],
    );
  }
}

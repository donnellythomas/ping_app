import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:ping_app/models/message.dart';

class MeBubble extends StatelessWidget {
  final Message message;
  MeBubble({this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 4, bottom: 2),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              message.author,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ),
        ),
        Bubble(
          style: BubbleStyle(
            nip: BubbleNip.rightBottom,
            color: Colors.amber[700],
            margin: BubbleEdges.only(top: 0.0, left: 50.0, bottom: 8, right: 4),
            alignment: Alignment.topRight,
          ),
          child: Text(message.content),
        ),
      ],
    );
  }
}

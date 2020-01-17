import 'package:flutter/material.dart';
import 'package:ping_app/models/chat_room.dart';
import 'package:ping_app/screens/chat.dart';

class MessageCard extends StatelessWidget {
  final List<ChatRoom> chatList;
  final int index;
  MessageCard({this.chatList, this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red,
            child: Text(
              'SOS',
              style: TextStyle(color: Colors.white, fontFamily: 'bebas'),
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(12, 4, 12, 4),
          title: Text(chatList[index].name),
          subtitle: Text('Custom Message Here'),
          onTap: () => Navigator.pushNamed(context, 'secondScreen')),
    );
  }
}

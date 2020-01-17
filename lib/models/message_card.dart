import 'package:flutter/material.dart';
import 'package:ping_app/models/chat_room.dart';
import 'package:ping_app/screens/chat.dart';

class MessageCard extends StatelessWidget {
  final List<ChatRoom> chatList;
  final int index;
  MessageCard({this.chatList, this.index});

  @override
  Widget build(BuildContext context) {
    ChatRoom currentChat = chatList[index];
    return Card(
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red,
            child: Text(
              'SOS!',
              style: TextStyle(color: Colors.white, fontFamily: 'bebas'),
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(12, 4, 12, 4),
          title: Text(currentChat.name),
          subtitle: Text(currentChat.owner + ' - ' + currentChat.mainMessage),
          onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => ChatBoard(
                  title: currentChat.name,
                  locationLink: currentChat.location,
                  mainMessage: currentChat.mainMessage,
                  owner: currentChat.owner,
                ),
              ))),
    );
  }
}

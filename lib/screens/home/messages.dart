import 'package:flutter/material.dart';
import 'package:ping_app/models/chat_room.dart';
import 'package:ping_app/models/message_card.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  const Messages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatRoom> chatList = Provider.of<List<ChatRoom>>(context);
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(
            fontSize: 35,
            color: Colors.deepPurple,
            fontFamily: 'futura',
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: chatList == null ? 0 : chatList.length,
        itemBuilder: (BuildContext context, int index) {
          return MessageCard(chatList: chatList, index: index);
        },
      ),
    );
  }
}

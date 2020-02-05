import 'package:flutter/material.dart';
import 'package:ping_app/models/chat_room.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/main/messages/message_card.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  const Messages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatRoom> chatList = Provider.of<List<ChatRoom>>(context);
    chatList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    UserData userData = Provider.of<UserData>(context);

    Widget child;
    if (chatList == null || chatList.length == 0) {
      child = Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          'No one has pinged you yet.',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 24,
          ),
        ),
      );
    }
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
      body: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: ListView.builder(
          itemCount: chatList == null ? 0 : chatList.length,
          itemBuilder: (BuildContext context, int index) {
            print(chatList[index].cid);
            if (!(userData.deletedChats.contains(chatList[index].cid))) {
              return MessageCard(chatList: chatList, index: index);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

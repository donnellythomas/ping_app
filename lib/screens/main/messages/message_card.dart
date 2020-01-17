import 'package:flutter/material.dart';
import 'package:ping_app/models/chat_room.dart';
import 'package:ping_app/models/message.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/main/messages/chatroom/chat.dart';
import 'package:ping_app/services/database.dart';
import 'package:provider/provider.dart';

class MessageCard extends StatelessWidget {
  final List<ChatRoom> chatList;
  final int index;
  MessageCard({this.chatList, this.index});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
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
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                    providers: [
                      StreamProvider<UserData>.value(
                        value: DatabaseService().userData(user.uid),
                      ),
                      StreamProvider<List<Message>>.value(
                          value: DatabaseService()
                              .getMessageList(currentChat.cid)),
                    ],
                    child: ChatBoard(
                        chatData: currentChat,
                        title: currentChat.name,
                        locationLink: currentChat.location,
                        mainMessage: currentChat.mainMessage,
                        owner: currentChat.owner,
                        cid: currentChat.cid)),
              ))),
    );
  }
}

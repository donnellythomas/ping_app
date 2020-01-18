import 'package:ping_app/models/chat_room.dart';
import 'package:ping_app/models/message.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/main/messages/chatroom/me_bubble.dart';
import 'package:ping_app/screens/main/messages/chatroom/someone_bubble.dart';

import 'package:ping_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ping_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBoard extends StatelessWidget {
  final String title;
  final String owner;
  final String location;
  final String mainMessage;
  final String cid;
  final ChatRoom chatData;

  ChatBoard(
      {this.title,
      this.location,
      this.mainMessage,
      this.owner,
      this.cid,
      this.chatData});
  @override
  Widget build(BuildContext context) {
    List<Message> messageList = Provider.of<List<Message>>(context);
    TextEditingController _controller = new TextEditingController();
    UserData userData = Provider.of<UserData>(context);

    return Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.deepPurple),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.deepPurple, //change your color here
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              // color: Colors.white,
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.red, width: 5),
                  color: Colors.white),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                    'SOS!',
                    style: TextStyle(color: Colors.white, fontFamily: 'bebas'),
                  ),
                ),
                title: Text(owner,
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(mainMessage,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
                trailing: RaisedButton(
                  child: Text('Link To Location',
                      style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
                  onPressed: () async {
                    launch(
                        'https://www.google.com/maps/search/?api=1&query=$location');
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: messageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (messageList[index].author == userData.name) {
                      return MeBubble(
                        message: messageList[index],
                      );
                    } else {
                      return SomeoneBubble(
                        message: messageList[index],
                      );
                    }
                  },
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: TextField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Type Message Here'),
                      controller: _controller,
                      onSubmitted: (val) async {
                        // print(cid);
                        await DatabaseService()
                            .sendChatMessage(val, userData.name, cid);
                        _controller.clear();
                      }),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     height: 60,
                //     child: FlatButton(
                //       color: Colors.white,
                //       child: Text('Send'),
                //       onPressed: () {},
                //     ),
                //   ),
                // )
              ],
            )
          ],
        ));
  }
}

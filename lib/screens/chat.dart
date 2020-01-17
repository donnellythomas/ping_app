import 'package:ping_app/shared/someone_bubble.dart';
import 'package:flutter/material.dart';
import 'package:ping_app/shared/constants.dart';

class ChatBoard extends StatelessWidget {
  final String title;
  final String owner;
  final String locationLink;
  final String mainMessage;

  ChatBoard({this.title, this.locationLink, this.mainMessage, this.owner});
  @override
  Widget build(BuildContext context) {
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
                trailing: Text('Link To Location',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return SomeoneBubble();
                  },
                ),
              ),
            ),
            TextField(
              decoration:
                  textInputDecoration.copyWith(hintText: 'Type Message Here'),
            )
          ],
        ));
  }
}

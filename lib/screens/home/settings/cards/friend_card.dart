import 'package:flutter/material.dart';
import 'package:ping_app/models/friend.dart';

class FriendCard extends StatelessWidget {
  final Friend friend;
  final String gid;
  FriendCard({this.friend, this.gid});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              friend.uid,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.not_interested),
              onPressed: () async {
                print(gid);
                // await DatabaseService(uid: user.uid).removePerson(userData.name, gid);
              })
        ],
      ),
    );
  }
}

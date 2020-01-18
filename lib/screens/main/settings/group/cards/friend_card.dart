import 'package:flutter/material.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/services/database.dart';
import 'package:provider/provider.dart';

class FriendCard extends StatelessWidget {
  final String friendUid;
  final String gid;
  FriendCard({this.friendUid, this.gid});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return FutureBuilder(
        future: DatabaseService().getName(friendUid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Card(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ]));
          } else {
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      snapshot.data,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.not_interested),
                      onPressed: () async {
                        // print(gid);
                        await DatabaseService()
                            .removeFriend(friendUid, user.uid, gid);
                      })
                ],
              ),
            );
          }
        });
  }
}

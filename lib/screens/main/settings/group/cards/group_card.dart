import 'package:flutter/material.dart';
import 'package:ping_app/models/group.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/main/settings/group/alerts/textfield_alert_dialog_addFriend.dart';
import 'package:ping_app/screens/main/settings/group/cards/friend_card.dart';
import 'package:ping_app/services/database.dart';
import 'package:provider/provider.dart';

class GroupCard extends StatelessWidget {
  final Group group;
  GroupCard({this.group});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    void _showAlertDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: TextFieldAlertDialog(
                gid: group.gid,
              ),
            );
          });
    }

    // print("card ID " + gid);
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Switch(
                      value: group.isSelected,
                      onChanged: (value) async {
                        return await DatabaseService()
                            .switchToggle(value, group.gid, user.uid);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8.0),
                      child: Text(
                        group.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton.icon(
                icon: Icon(Icons.add),
                label: Text(
                  'Add Friend',
                ),
                onPressed: () {
                  _showAlertDialog();
                },
              )
            ],
          ),
          Container(
              height: 100,
              color: Colors.grey[300],
              child: ListView.builder(
                itemCount: group.friendUids.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  // print(group.friends.length);
                  return FriendCard(
                    friendUid: group.friendUids[index],
                    gid: group.gid,
                  );
                },
              ))
        ],
      ),
    );
  }
}

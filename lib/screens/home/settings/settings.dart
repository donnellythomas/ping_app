import 'package:flutter/material.dart';
import 'package:ping_app/models/group.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/home/settings/panels/group_editor.dart';
import 'package:ping_app/services/auth.dart';
import 'package:ping_app/services/database.dart';
import 'package:ping_app/shared/constants.dart';
import 'package:ping_app/shared/loading.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 35,
            color: Colors.deepPurple,
            fontFamily: 'futura',
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              // List<Group> groupList = snapshot.data.
              print("groupList:");
              // print(groupList);
              return ListView(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          'SOS MESSAGE',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: userData.message,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Type Message here'),
                      onChanged: (val) async {
                        await DatabaseService(uid: user.uid)
                            .updateMessage(val ?? userData.message);
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          'MY GROUPS',
                        ),
                      )),
                  GroupEditor(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton.icon(
                      color: Colors.white,
                      icon: Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      label: Text(
                        'logout',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      onPressed: () async {
                        await _auth.signOut();
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}

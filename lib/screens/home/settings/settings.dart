import 'package:flutter/material.dart';
import 'package:ping_app/models/group.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/home/settings/panels/group_editor.dart';
import 'package:ping_app/services/auth.dart';
import 'package:ping_app/services/database.dart';
import 'package:ping_app/shared/constants.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final userData = Provider.of<UserData>(context);

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
        body: ListView(
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
                initialValue:
                    userData == null ? 'default message' : userData.message,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Type Message here'),
                onChanged: (val) async {
                  await DatabaseService()
                      .updateMessage(val ?? userData.message, user.uid);
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
            StreamProvider<List<Group>>.value(
              value: DatabaseService().groupList(user.uid),
              child: GroupEditor(),
            ),
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
        ));
  }
}

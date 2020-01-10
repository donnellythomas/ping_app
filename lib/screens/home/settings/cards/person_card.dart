import 'package:flutter/material.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/services/database.dart';
import 'package:provider/provider.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String gid;
  PersonCard({this.name, this.gid});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.not_interested),
              onPressed: () async {
                print(gid);
                await DatabaseService(uid: user.uid).removePerson(name, gid);
              })
        ],
      ),
    );
  }
}

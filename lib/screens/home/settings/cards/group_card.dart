import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ping_app/screens/home/settings/cards/person_card.dart';
import 'package:ping_app/services/database.dart';
import 'package:ping_app/shared/textfield_alert_dialog_addPerson.dart';

class GroupCard extends StatelessWidget {
  final String gid;
  final String name;
  final List<String> people;
  GroupCard({
    this.gid,
    this.name,
    this.people,
  });

  @override
  Widget build(BuildContext context) {
    void _showAlertDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: TextFieldAlertDialog(
                gid: gid,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton.icon(
                icon: Icon(Icons.add),
                label: Text(
                  'Add People',
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
                itemCount: people == null ? 0 : people.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return PersonCard(
                    name: people[index],
                    gid: gid,
                  );
                },
              ))
        ],
      ),
    );
  }
}

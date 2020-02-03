import 'package:flutter/material.dart';
import 'package:ping_app/models/group.dart';
import 'package:ping_app/screens/main/settings/group/cards/group_card.dart';

import 'package:provider/provider.dart';

import 'alerts/textfield_alert_dialog_addGroup.dart';

class GroupEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Group> groupList = Provider.of<List<Group>>(context);

    void _showAlertDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: TextFieldAlertDialog(),
            );
          });
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(12),
      height: 350,
      color: Colors.red[100],
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'My Groups',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.add,
                  color: Colors.deepPurple,
                ),
                label: Text(
                  'Add Group',
                  style: TextStyle(color: Colors.deepPurple),
                ),
                onPressed: () async {
                  _showAlertDialog();
                },
              )
            ],
          ),
          Expanded(
            child: Container(
              // height: 200.0,
              margin: EdgeInsets.all(0),
              color: Colors.red[100],
              child: new ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: groupList == null ? 0 : groupList.length,
                itemBuilder: (context, index) {
                  return GroupCard(
                    group: groupList[index],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

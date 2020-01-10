import 'package:flutter/material.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/home/settings/cards/group_card.dart';
import 'package:ping_app/screens/home/settings/cards/person_card.dart';
import 'package:ping_app/services/database.dart';
import 'package:ping_app/shared/loading.dart';
import 'package:ping_app/shared/textfield_alert_dialog_addGroup.dart';
import 'package:provider/provider.dart';

class GroupEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final List<GroupCard> groupList = Provider.of<List<GroupCard>>(context);

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
      height: 400,
      color: Colors.white,
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
                  ),
                ),
              ),
              FlatButton.icon(
                icon: Icon(Icons.add),
                label: Text(
                  'Add Group',
                ),
                onPressed: () async {
                  _showAlertDialog();
                  // await DatabaseService(uid: user.uid).setGoupData(
                  //     'default group name', ['null', null]);
                },
              )
            ],
          ),
          Expanded(
            child: Container(
              // height: 200.0,
              margin: EdgeInsets.all(0),
              color: Colors.grey[100],
              child: new ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: groupList == null ? 0 : groupList.length,
                itemBuilder: (context, index) {
                  return groupList[index];
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

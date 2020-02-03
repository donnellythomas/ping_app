import 'package:flutter/material.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/services/database.dart';
import 'package:ping_app/shared/constants.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class TextFieldAlertDialog extends StatefulWidget {
  @override
  _TextFieldAlertDialogState createState() => _TextFieldAlertDialogState();
  final String gid;
  TextFieldAlertDialog({this.gid});
}

class _TextFieldAlertDialogState extends State<TextFieldAlertDialog> {
  TextEditingController _textFieldController = TextEditingController();
  String _currentName;
  final _formKey = GlobalKey<FormState>();
  String error = '';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: null,
        builder: (context, snapshot) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            backgroundColor: Colors.grey[200],
            title: Text('Enter a friends email'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _textFieldController,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'type email here'),
                    validator: (val) {
                      return val.isEmpty ? 'Please enter a name' : null;
                    },
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 5,
                  ),
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('CONFIRM'),
                onPressed: () async {
                  // print(_currentName);
                  if (await DatabaseService()
                      .checkEmailExists(_currentName)
                      .then((value) => value == true)) {
                    String friendUid =
                        await DatabaseService().getUidFromEmail(_currentName);

                    await DatabaseService()
                        .addFriend(friendUid, user.uid, widget.gid);

                    Navigator.pop(context);
                  } else {
                    setState(() {
                      error = 'Please enter a registered user';
                    });
                  }
                },
              )
            ],
          );
        });
  }
}

// _checkEmailValid(String val) {}

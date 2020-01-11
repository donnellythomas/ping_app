import 'package:flutter/material.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/services/database.dart';
import 'package:ping_app/shared/constants.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: null,
        builder: (context, snapshot) {
          return AlertDialog(
            backgroundColor: Colors.grey[200],
            title: Text('Enter a friends name'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _textFieldController,
                decoration:
                    textInputDecoration.copyWith(hintText: 'type name here'),
                validator: (val) {
                  return val.isEmpty ? 'Please enter a name' : null;
                },
                onChanged: (val) => setState(() => _currentName = val),
              ),
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
                    await DatabaseService(uid: user.uid)
                        .addPerson(_currentName, widget.gid);
                    print('username exists');
                    Navigator.pop(context);
                  } else {
                    print('enter a valid email');
                  }
                },
              )
            ],
          );
        });
  }
}

_checkEmailValid(String val) {}

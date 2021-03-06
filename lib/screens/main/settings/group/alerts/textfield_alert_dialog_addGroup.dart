import 'package:flutter/material.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/services/database.dart';
import 'package:ping_app/shared/constants.dart';
import 'package:provider/provider.dart';

class TextFieldAlertDialog extends StatefulWidget {
  @override
  _TextFieldAlertDialogState createState() => _TextFieldAlertDialogState();
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
            title: Text('Enter Group Name'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _textFieldController,
                decoration:
                    textInputDecoration.copyWith(hintText: 'type name here'),
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
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
                  if (_formKey.currentState.validate()) {
                    await DatabaseService()
                        .setGoupData(_currentName, user.uid, false);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          );
        });
  }
}

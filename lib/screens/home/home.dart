import 'package:flutter/material.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final List<String> groupList = Provider.of<List<String>>(context);
    final User user = Provider.of<User>(context);
    final UserData userData = Provider.of<UserData>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Ping!',
            style: TextStyle(
                fontSize: 120,
                fontFamily: 'Lobster',
                color: Colors.deepPurple[800])),
        SizedBox(
          height: 50,
        ),
        RawMaterialButton(
          onPressed: () {
            DatabaseService().createChats(userData);
          },
          child: Text(
            'SOS!',
            style: TextStyle(
              fontFamily: 'bebas',
              fontSize: 100,
              color: Colors.white,
            ),
          ),
          shape: new CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.red[500],
          padding: const EdgeInsets.all(50.0),
        ),
      ],
    );
  }
}

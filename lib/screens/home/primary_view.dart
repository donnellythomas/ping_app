import 'package:flutter/material.dart';
import 'package:ping_app/models/chat_room.dart';
import 'package:ping_app/models/group.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/home/settings/settings.dart';
import 'package:ping_app/services/database.dart';
import 'package:provider/provider.dart';
import 'messages.dart';
import 'home.dart';

class PrimaryView extends StatefulWidget {
  PrimaryView({Key key}) : super(key: key);

  @override
  _PrimaryViewState createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView> {
  int _selectedIndex = 1;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Messages(),
    Home(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<UserData>.value(
          value: DatabaseService().userData(user.uid),
        ),
        StreamProvider<List<Group>>.value(
            value: DatabaseService().groupList(user.uid)),
        StreamProvider<List<ChatRoom>>.value(
          value: DatabaseService().chatList(user),
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.red[100],
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.amber[700],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color: Colors.deepPurple,
                size: 50,
              ),
              title: Text('Messages'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.deepPurple,
                size: 50,
              ),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.deepPurple, size: 50),
              title: Text('Settings'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

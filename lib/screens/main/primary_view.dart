import 'package:flutter/material.dart';
import 'package:ping_app/models/chat_room.dart';
import 'package:ping_app/models/group.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/main/home/home.dart';
import 'package:ping_app/screens/main/messages/messages.dart';
import 'package:ping_app/screens/main/settings/settings.dart';
import 'package:ping_app/services/database.dart';
import 'package:provider/provider.dart';

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
          value: DatabaseService().chatList(user.uid),
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
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/personIcon.png',
                height: 50,
              ),
              title: Text('Messages'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/homeIcon.png',
                height: 50,
              ),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/settingsIcon.png',
                height: 50,
              ),
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

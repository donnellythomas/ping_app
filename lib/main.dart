import 'package:flutter/material.dart';
import 'package:ping_app/screens/authenticate/authenticate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authenticate(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ping_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    return Home();
  }
}

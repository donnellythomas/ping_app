import 'package:flutter/material.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'home/primary_view.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either home or authenticate widget
    return user != null ? PrimaryView() : Authenticate();
  }
}

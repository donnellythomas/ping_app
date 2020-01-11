import 'package:ping_app/screens/home/settings/cards/group_card.dart';

class User {
  final String uid;

  User({
    this.uid,
  });
}

class UserData {
  final String uid;
  final String message;
  final String email;
  final List<GroupCard> groups;
  UserData({
    this.uid,
    this.email,
    this.message,
    this.groups,
  });
}

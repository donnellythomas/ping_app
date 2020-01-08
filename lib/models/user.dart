import 'group.dart';

class User {
  final String uid;

  User({
    this.uid,
  });
}

class UserData {
  final String uid;
  final String message;
  final List<Group> groups;

  UserData({this.uid, this.message, this.groups});
}

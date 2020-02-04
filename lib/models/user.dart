class User {
  final String uid;

  User({
    this.uid,
  });
}

class UserData {
  final String uid;
  final String name;
  final String message;
  final String email;
  final List<String> deletedChats;

  UserData({this.uid, this.email, this.name, this.message, this.deletedChats});
}

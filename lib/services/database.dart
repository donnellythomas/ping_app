import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  static final Firestore db = Firestore.instance;

  final CollectionReference users = db.collection('users');

  Future updateUserData(
    String message,
  ) async {
    return await users.document(uid).setData({
      'message': 'my message',
    });
  }

  Future updateGroupData(String groupname, String uid) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(groupname)
        .setData({'person': 'name'});
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference users = Firestore.instance.collection('users');

  Future updateUserData(
    String name,
    String email,
  ) async {
    return await users.document(uid).setData({
      'name': name,
      'email': email,
      'groups': {
        'groupNum': {'user1': 'user1'}
      }
    });
  }
}

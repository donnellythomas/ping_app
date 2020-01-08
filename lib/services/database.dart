import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ping_app/models/group.dart';
import 'package:ping_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  static final Firestore db = Firestore.instance;

  final CollectionReference users = db.collection('users');

  Future setUserData(
    String message,
    // List<Group> groups,
  ) async {
    return await users.document(uid).setData({
      'message': message,
      // 'groups': groups,
    });
  }

  Future setGoupData(String groupName, List<String> people) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(groupName)
        .setData({'people': people});
  }

  Future updateMessage(String message) async {
    return await users.document(uid).updateData({
      'message': message,
    });
  }

  Future addGroup(String groupname, List<String> people) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(groupname)
        .updateData({'people': people});
  }
  // Future addGroup(String groupName) async {
  //   return await users
  //       .document(uid)
  //       .updateData({'groups': UserData.groups
  // }

  // Future addGroup(String groupname) async {
  //   return await users
  //       .document(uid)
  //       .collection('groups')
  //       .document(groupname)
  //       .updateData({'group': groupname});
  // }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      message: snapshot.data['message'],
      // groups: snapshot.data['groups'],
    );
  }

  //userGroups from snapshot

  //get user doc stream aka get user data from firestore
  Stream<UserData> get userData {
    return users.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/home/settings/cards/group_card.dart';
import 'package:ping_app/screens/home/settings/cards/person_card.dart';

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
    });
  }

  Future setGoupData(String groupName, List<String> people) async {
    return await users
        .document(uid)
        .collection('groups')
        .document()
        .setData({'name': groupName, 'people': people});
  }

  Future updateMessage(String message) async {
    return await users.document(uid).updateData({
      'message': message,
    });
  }

  // Future addGroup(String groupname, List<String> people) async {
  //   return await users
  //       .document(uid)
  //       .collection('groups')
  //       .document()
  //       .updateData({'people': people});
  // }
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
      groups: snapshot.data['groups'],
    );
  }

  //userGroups from snapshot

  //get user doc stream aka get user data from firestore
  Stream<UserData> get userData {
    return users.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  List<GroupCard> _groupListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return GroupCard(
        gid: doc.documentID,
        name: doc.data['name'] ?? 'default name',
        people: List.from(doc['people']),
      );
    }).toList();
  }

  //get list of groups from firestore
  Stream<List<GroupCard>> get groupList {
    return users
        .document(uid)
        .collection('groups')
        .snapshots()
        .map(_groupListFromSnapshot);
  }

  Future removePerson(String name, String gid) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(gid)
        .updateData({
      'people': FieldValue.arrayRemove([name])
    });
  }

  // Stream<List<String>> getPeople(String gid) {
  //   return users
  //       .document(uid)
  //       .collection('groups')
  //       .document(gid)
  //       .snapshots()
  //       .map((doc) {
  //     return doc.data['people'];
  //   });
  // }
}

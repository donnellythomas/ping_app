import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/screens/home/settings/cards/group_card.dart';
import 'package:ping_app/screens/home/settings/cards/person_card.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  static final Firestore db = Firestore.instance;

  final CollectionReference users = db.collection('users');
  final CollectionReference emailToUid = db.collection('emailToUid');
  Future setUserData(
    String message,
    String email,
    // List<Group> groups,
  ) async {
    return await users.document(uid).setData({
      'message': message,
      'email': email,
      'uid': uid,
    });
  }

  Future setGoupData(
      String groupName, List<String> people, bool switchValue) async {
    return await users.document(uid).collection('groups').document().setData(
        {'name': groupName, 'people': people, 'switchValue': switchValue});
  }

  Future updateMessage(String message) async {
    return await users.document(uid).updateData({
      'message': message,
    });
  }

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
      // print("document id " + doc.documentID);
      return GroupCard(
        gid: doc.documentID,
        name: doc.data['name'] ?? 'default name',
        people: List.from(doc['people']),
        switchValue: doc.data['switchValue'],
      );
    }).toList();
  }

  List<String> _groupListStringFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return doc.data['name'].toString();
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

  //get list of groups from firestore
  Stream<List<String>> get groupListString {
    return users
        .document(uid)
        .collection('groups')
        .snapshots()
        .map(_groupListStringFromSnapshot);
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

  Future addPerson(String name, String gid) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(gid)
        .updateData({
      'people': FieldValue.arrayUnion([name])
    });
  }

  Future switchToggle(bool switchValue, String gid) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(gid)
        .updateData({'switchValue': switchValue});
  }

  Future addEmailToUid(String email) async {
    return await emailToUid.document(email).setData({'uid': uid});
  }

  Future<bool> checkEmailExists(String email) async {
    return await emailToUid.document(email).get().then((snap) {
      if (snap.exists) {
        return true;
      } else {
        return false;
      }
    });
  }
}

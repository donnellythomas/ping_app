import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ping_app/models/chat_room.dart';
import 'package:ping_app/models/friend.dart';
import 'package:ping_app/models/group.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/models/chat_room.dart';

class DatabaseService {
  static final Firestore db = Firestore.instance;

  //References for all the collections
  final CollectionReference users = db.collection('users');
  final CollectionReference emailToUid = db.collection('emailToUid');
  final CollectionReference chats = db.collection('chats');

  //Setters
  Future setUserData(
    String uid,
    String message,
    String name,
    String email,
  ) async {
    return await users.document(uid).setData({
      'message': message,
      'email': email,
      'name': name,
      'uid': uid,
    });
  }

  Future setGoupData(
    String name,
    String uid,
    bool isSelected,
  ) async {
    DocumentReference groupDoc =
        users.document(uid).collection('groups').document();
    return await groupDoc.setData({
      'gid': groupDoc.documentID,
      'name': name,
      'isSelected': isSelected,
      'friends': []
    });
  }

  //Updaters
  Future updateMessage(String message, String uid) async {
    return await users.document(uid).updateData({
      'message': message,
    });
  }

  // Future removePerson(UserData person, String gid) async {
  //   return await users
  //       .document(uid)
  //       .collection('groups')
  //       .document(gid)
  //       .updateData({
  //     'people': FieldValue.arrayRemove([person])
  //   });
  // }

  Future addFriend(Friend friend, String uid, String gid) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(gid)
        .updateData({
      'friends': FieldValue.arrayUnion([
        {'uid': friend.uid, 'email': friend.email, 'name': friend.name}
      ])
    });
  }

  Future switchToggle(bool isSelected, String gid, String uid) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(gid)
        .updateData({'isSelected': isSelected});
  }

  Future addEmailToUid(String email, String uid) async {
    return await emailToUid.document(email).setData({'uid': uid});
  }

//GETTERS

  //get userData from FireBase
  Stream<UserData> userData(String uid) {
    return users
        .document(uid)
        .snapshots()
        .map((snapshot) => _userDataFromSnapshot(snapshot, uid));
  }

  //Map snapshot to userData
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot, String uid) {
    return UserData(
      uid: uid,
      message: snapshot.data['message'],
      name: snapshot.data['name'],
      email: snapshot.data['email'],
    );
  }

  Stream<List<ChatRoom>> chatList(User user) {
    // print(uid);
    return chats
        .where('users', arrayContains: {
          'uid': user.uid,
          'email': 'test1@test.com',
          'name': 'default name'
        })
        .snapshots()
        .map(_chatRoomFromSnapshot);
  }

  List<ChatRoom> _chatRoomFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => ChatRoom(
            messages: List.from(doc.data['messages']),
            name: doc.data['name'],
            friends: List.from(doc.data['users'].map((index) => Friend(
                email: index['email'],
                name: index['name'],
                uid: index['uid'])))))
        .toList();
  }

  Stream<List<Group>> groupList(String uid) {
    return users
        .document(uid)
        .collection('groups')
        .snapshots()
        .map(_groupListFromSnapshot);
  }

  Future<String> getUidFromEmail(String email) {
    return emailToUid.document(email).get().then((doc) => doc.data['uid']);
  }

  Future<Friend> getFriendData(String uid) {
    return users.document(uid).get().then((doc) =>
        Friend(email: doc.data['email'], name: doc.data['name'], uid: uid));
  }

  List<Group> _groupListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Group(
            name: doc.data['name'],
            isSelected: doc.data['isSelected'],
            gid: doc.data['gid'],
            friends: List.from(doc.data['friends'].map((index) => Friend(
                email: index['email'],
                name: index['name'],
                uid: index['uid'])))))
        .toList();
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

  Future createChats(String uid) async {
    return await users
        .document(uid)
        .collection('groups')
        .where('isSelected', isEqualTo: true)
        .getDocuments()
        .then((doc) {
      return doc.documents.forEach((doc) => _createChat(doc));
    });
  }

  Future _createChat(DocumentSnapshot doc) async {
    return await chats.document().setData({
      'users': doc.data['friends'],
      'messages': [],
      'name': doc.data['name']
    });
  }
}

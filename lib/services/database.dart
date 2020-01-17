import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ping_app/models/chat_room.dart';

import 'package:ping_app/models/group.dart';
import 'package:ping_app/models/message.dart';
import 'package:ping_app/models/user.dart';

class DatabaseService {
  static final Firestore db = Firestore.instance;

  //References for all the collections
  final CollectionReference users = db.collection('users');
  final CollectionReference emailToUid = db.collection('emailToUid');
  final CollectionReference chats = db.collection('chats');

  //USER------------------------------------------------------------------------

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

  //----------------------------------------------------------------------------
  //USERDATA--------------------------------------------------------------------
  Stream<UserData> userData(String uid) {
    return users
        .document(uid)
        .snapshots()
        .map((snapshot) => _userDataFromSnapshot(snapshot, uid));
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot, String uid) {
    return UserData(
      uid: uid,
      message: snapshot.data['message'],
      name: snapshot.data['name'],
      email: snapshot.data['email'],
    );
  }

  Future updateMessage(String message, String uid) async {
    return await users.document(uid).updateData({
      'message': message,
    });
  }

  Future setName(String uid, String name) {
    return users.document(uid).updateData({'name': name});
  }

  Future<String> getName(String uid) {
    return users.document(uid).get().then((doc) => doc.data['name']);
  }

  Future<String> getEmail(String uid) {
    return users.document(uid).get().then((doc) => doc.data['email']);
  }

  Future addEmailToUid(String email, String uid) async {
    return await emailToUid.document(email).setData({'uid': uid});
  }

  Future<String> getUidFromEmail(String email) {
    return emailToUid.document(email).get().then((doc) => doc.data['uid']);
  }

  Future<UserData> getUserDataFromUid(String uid) {
    return users.document(uid).get().then((doc) => UserData(
        email: doc.data['email'],
        name: doc.data['name'],
        message: doc.data['message'],
        uid: uid));
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

  Future createChats(UserData userData) async {
    return await users
        .document(userData.uid)
        .collection('groups')
        .where('isSelected', isEqualTo: true)
        .getDocuments()
        .then((doc) {
      return doc.documents.forEach((doc) => _createChat(doc, userData));
    });
  }
  //----------------------------------------------------------------------------

  //GROUP-----------------------------------------------------------------------
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
      'friendUids': [uid]
    });
  }

  Future removeFriend(String friendUid, String uid, String gid) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(gid)
        .updateData({
      'friendUids': FieldValue.arrayRemove([friendUid])
    });
  }

  Future addFriend(String friendUid, String uid, String gid) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(gid)
        .updateData({
      'friendUids': FieldValue.arrayUnion([friendUid])
    });
  }

  Future switchToggle(bool isSelected, String gid, String uid) async {
    return await users
        .document(uid)
        .collection('groups')
        .document(gid)
        .updateData({'isSelected': isSelected});
  }

  Stream<List<Group>> groupList(String uid) {
    return users
        .document(uid)
        .collection('groups')
        .snapshots()
        .map(_groupListFromSnapshot);
  }

  List<Group> _groupListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Group(
            name: doc.data['name'],
            isSelected: doc.data['isSelected'],
            gid: doc.data['gid'],
            friendUids: List.from(doc.data['friendUids'])))
        .toList();
  }

//------------------------------------------------------------------------------
//CHATROOM----------------------------------------------------------------------
  Stream<List<ChatRoom>> chatList(String uid) {
    return chats
        .where(
          'users',
          arrayContains: uid,
        )
        .snapshots()
        .map(_chatRoomFromSnapshot);
  }

  List<ChatRoom> _chatRoomFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => ChatRoom(
            messages: List.from(doc.data['messages'].map((index) => Message(
                  author: index['author'],
                  content: index['message'],
                ))),
            name: doc.data['name'],
            friendUids: List.from(doc.data['users']),
            owner: doc.data['owner'],
            mainMessage: doc.data['mainMessage'],
            location: doc.data['location'],
            cid: doc.data['cid']))
        .toList();
  }

  Future _createChat(DocumentSnapshot doc, UserData owner) async {
    DocumentReference chatRef = chats.document();
    return await chatRef.setData({
      'cid': chatRef.documentID,
      'users': doc.data['friendUids'],
      'messages': [],
      'name': doc.data['name'],
      'owner': owner.name,
      'mainMessage': owner.message,
      'location': 'LocationLink',
    });
  }

  Future sendChatMessage(String message, String author, String cid) async {
    return await chats.document(cid).updateData({
      'messages': FieldValue.arrayUnion([
        {'author': author, 'message': message}
      ])
    });
  }
//------------------------------------------------------------------------------

}

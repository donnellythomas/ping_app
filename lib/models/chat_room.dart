import 'package:ping_app/screens/home/messages.dart';

import 'friend.dart';

class ChatRoom {
  final List<Friend> friends;
  final List<Messages> messages;
  final String name;

  ChatRoom({this.friends, this.messages, this.name});
}

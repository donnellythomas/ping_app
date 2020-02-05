import 'package:ping_app/models/message.dart';

class ChatRoom {
  final String cid;
  final List<String> friendUids;
  final List<Message> messages;
  final String name;
  final String owner;
  final String mainMessage;
  final String location;
  final DateTime timestamp;

  ChatRoom(
      {this.cid,
      this.friendUids,
      this.messages,
      this.name,
      this.owner,
      this.mainMessage,
      this.location,
      this.timestamp});
}

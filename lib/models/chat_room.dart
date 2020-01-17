import 'package:ping_app/screens/home/messages.dart';

class ChatRoom {
  final List<String> friendUids;
  final List<Messages> messages;
  final String name;
  final String sender;
  final String notificationMessage;

  ChatRoom(
      {this.friendUids,
      this.messages,
      this.name,
      this.sender,
      this.notificationMessage});
}

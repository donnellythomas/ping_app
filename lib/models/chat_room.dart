import 'package:ping_app/screens/home/messages.dart';

class ChatRoom {
  final List<String> friendUids;
  final List<Messages> messages;
  final String name;
  final String owner;
  final String mainMessage;
  final String location;

  ChatRoom(
      {this.friendUids,
      this.messages,
      this.name,
      this.owner,
      this.mainMessage,
      this.location});
}

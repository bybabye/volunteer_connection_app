import 'package:volunteer_connection/core/entites/user.dart';

class Message {
  final String id;
  final String chatId;
  final String type;
  final User sender;
  final String content;
  final DateTime sentTime;

  Message(
      {required this.id,
      required this.type,
      required this.sender,
      required this.content,
      required this.sentTime,
      required this.chatId});

  factory Message.fromJson(Map<String, dynamic> json) {
    final User sender = User.fromJson(json['senderId']);
    // Chuyển đổi dữ liệu từ JSON thành kiểu DateTime
    final DateTime sentTime = DateTime.parse(json['sentTime']);
    return Message(
      id: json['_id'] ?? "",
      chatId: json['chatId'] ?? "",
      type: json['type'] ?? "",
      sender: sender,
      content: json['content'] ?? "",
      sentTime: sentTime,
    );
  }
}

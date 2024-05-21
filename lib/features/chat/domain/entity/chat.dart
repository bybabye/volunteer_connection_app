import 'package:volunteer_connection/core/entites/user.dart';

class Chat {
  final String id;
  final String type;
  final List<User> members;
  final String lastMess;
  final String avatar;
  final String name;

  Chat(
      {required this.id,
      required this.type,
      required this.members,
      required this.lastMess,
      required this.avatar,
      required this.name});

  factory Chat.fromJson(Map<String, dynamic> json) {
    List<User> parsedMembers = [];
    if (json['members'] != null) {
      var memberList = json['members'] as List;
      parsedMembers =
          memberList.map((member) => User.fromJson(member)).toList();
    }

    return Chat(
      id: json['_id'] ?? "",
      type: json['type'] ?? "",
      members: parsedMembers,
      lastMess: json['lastMess'] ?? "",
      avatar: json['avatar'] ?? "",
      name: json['nameGruop'] ?? "",
    );
  }
}

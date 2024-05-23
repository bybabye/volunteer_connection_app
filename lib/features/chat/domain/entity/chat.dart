import 'package:volunteer_connection/core/entites/user.dart';

class Chat {
  final String id;
  final String type;
  final List<User> members;
  final List<User> administrator;
  final List<User> pending;
  final String lastMess;
  final String avatar;
  final String name;

  Chat(
      {required this.administrator,
      required this.pending,
      required this.id,
      required this.type,
      required this.members,
      required this.lastMess,
      required this.avatar,
      required this.name});

  factory Chat.fromJson(Map<String, dynamic> json) {
    List<User> parsedMembers = [];
    List<User> parsedAdministrator = [];
    List<User> pending = [];
    if (json['members'] != null) {
      var memberList = json['members'] as List;
      parsedMembers =
          memberList.map((member) => User.fromJson(member)).toList();
    }
    if (json['administrator'] != null) {
      var memberList = json['administrator'] as List;
      parsedAdministrator =
          memberList.map((member) => User.fromJson(member)).toList();
    }
    if (json['pending'] != null) {
      var memberList = json['pending'] as List;
      pending = memberList.map((member) => User.fromJson(member)).toList();
    }

    return Chat(
      id: json['_id'] ?? "",
      type: json['type'] ?? "",
      members: parsedMembers,
      lastMess: json['lastMess'] ?? "",
      avatar: json['avatar'] ?? "",
      name: json['nameGruop'] ?? "",
      administrator: parsedAdministrator,
      pending: pending,
    );
  }
}

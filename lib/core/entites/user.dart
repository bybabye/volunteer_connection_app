class User {
  final String id;
  final String name;
  final String email;

  final String roles;

  final String avatar;
  final String blood;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.avatar,
    required this.blood,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      roles: json['roles'] ?? "user",
      avatar: json['avatar'] ?? "",
      blood: json['blood'] ?? "",
      phone: json['phone'] ?? "",
    );
  }
}

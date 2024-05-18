class User {
  final String id;
  final String name;
  final String email;

  final String roles;

  final String avatar;
  final String blood;
  final String phone;
  final String placeOfOrigin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.avatar,
    required this.blood,
    required this.phone,
    required this.placeOfOrigin,
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
      placeOfOrigin: json['placeOfOrigin'] ?? "",
    );
  }

  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? placeOfOrigin,
  }) {
    return User(
      id: this.id,
      roles: this.roles,
      avatar: this.avatar,
      blood: this.blood,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      placeOfOrigin: placeOfOrigin ?? this.placeOfOrigin,
    );
  }
}

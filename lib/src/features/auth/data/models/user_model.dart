class UserModel {
  final int? id;
  final String name;
  final String username;
  final String password;
  final DateTime createdAt;

  const UserModel({
    this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.createdAt,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? password,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "password": password,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      name: map["name"],
      username: map["username"],
      password: map["password"],
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }
}

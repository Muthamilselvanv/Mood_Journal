class UserModel {
  final int? id;
  final String name;
  final String username;
  final String password;
  final String? profileImage;
  final String? bio;
  final DateTime createdAt;

  const UserModel({
    this.id,
    required this.name,
    required this.username,
    required this.password,
    this.profileImage,
    this.bio,
    required this.createdAt,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? password,
    String? profileImage,
    String? bio,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "password": password,
      "profileImage": profileImage,
      "bio": bio,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      name: map["name"],
      username: map["username"],
      password: map["password"],
      profileImage: map["profileImage"],
      bio: map["bio"],
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }
}

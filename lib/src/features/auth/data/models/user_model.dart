class UserModel {
  final int? id;
  final String firebaseUid;
  final String email;
  final String name;
  final String? profileImage;
  final String? bio;
  final DateTime createdAt;

  const UserModel({
    this.id,
    required this.firebaseUid,
    required this.email,
    required this.name,
    this.profileImage,
    this.bio,
    required this.createdAt,
  });

  UserModel copyWith({
    int? id,
    String? firebaseUid,
    String? email,
    String? name,
    String? profileImage,
    String? bio,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "firebaseUid": firebaseUid,
      "email": email,
      "name": name,
      "profileImage": profileImage,
      "bio": bio,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      firebaseUid: map["firebaseUid"],
      email: map["email"],
      name: map["name"],
      profileImage: map["profileImage"],
      bio: map["bio"],
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }
}

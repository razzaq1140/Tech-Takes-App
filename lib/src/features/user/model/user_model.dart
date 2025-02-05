class UserModel {
  final String name;
  final String email;
  final String id;
  final String photoURL;
  final String bio;
  UserModel(
      {required this.name,
      required this.email,
      required this.id,
      required this.photoURL,
      required this.bio});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoURL': photoURL,
      'id': id,
      'bio': bio,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      id: map['id'] as String,
      bio: map['bio'] as String,
      email: map['email'] as String,
      photoURL: map['photoURL'] as String,
    );
  }
}

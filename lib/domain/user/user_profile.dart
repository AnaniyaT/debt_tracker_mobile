class UserProfile {
  final String name;
  final String username;
  final String email;
  final String? profilePicture;
  final String? bio;
  final String id;

  UserProfile({
    required this.name,
    required this.username,
    required this.email,
    required this.id,
    this.profilePicture,
    this.bio,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      id: json['_id'],
      profilePicture: json['profilePicture'],
      bio: json['bio'],
    );
  }
}
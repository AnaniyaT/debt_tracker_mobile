class ChangeProfileForm {
  final String? name;
  final String? username;
  final String? email;
  final String? profilePicture;

  ChangeProfileForm({
    this.name,
    this.username,
    this.email,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
    };
  }
}
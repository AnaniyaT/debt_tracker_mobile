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

  Map<String, String> toJson() => {
  if (name != null) 'name': name!,
  if (username != null) 'username': username!,
  if (email != null) 'email': email!,
  if (profilePicture != null) 'profilePicture': profilePicture!,
};
}
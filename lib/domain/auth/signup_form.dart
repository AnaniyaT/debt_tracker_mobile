class SignupForm {
  final String name;
  final String username;
  final String email;
  final String password;

  SignupForm({
    required this.name,
    required this.username,
    required this.email,
    required this.password
  });

  Map<String, String> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password
    };
  }
}
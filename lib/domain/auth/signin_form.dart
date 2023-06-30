class SigninForm {
  final String usernameOrEmail;
  final String password;
  final bool? remember;

  SigninForm({
    required this.usernameOrEmail,
    required this.password,
    this.remember,
  });

  Map<String, dynamic> toJson() {
    return {
      'usernameOrEmail':usernameOrEmail,
      'password': password,
      'remember': remember?? false,
    };
  }
}
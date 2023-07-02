class ChangePasswordForm {
  String oldPassword;
  String newPassword;

  ChangePasswordForm({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, String> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}
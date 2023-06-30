import 'package:debt_tracker_mobile/domain/user/user.dart';

class AuthResponse {
  final User user;
  final String token;

  AuthResponse({
    required this.user,
    required this.token
  });

  factory AuthResponse.fromJson (Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user']),
      token: json['token']
    );
  }
}
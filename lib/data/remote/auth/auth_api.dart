import 'dart:convert';

import 'package:debt_tracker_mobile/domain/auth/auth.dart';
import 'package:debt_tracker_mobile/util/http_exception.dart';
import 'package:debt_tracker_mobile/util/http_service.dart';

class AuthApi {
  final HttpService _httpService = HttpService();
  final String _path = 'auth/';

  Future<AuthResponse> signup(Map<String, dynamic> signupForm) async {
    await _httpService.init();

    final response = await _httpService.post('${_path}signup', signupForm);

    if (response.statusCode == 201) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw DHttpException(
        jsonDecode(response.body)['message']  ?? 'Something went wrong',
        response.statusCode,
      );
    }
  }

  Future<AuthResponse> signin(Map<String, dynamic> signinForm) async {
    await _httpService.init();

    final response = await _httpService.post('${_path}signin', signinForm);
    if (response.statusCode == 201) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw DHttpException(
        jsonDecode(response.body)['message'] ?? 'Something went wrong',
        response.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> checkUsername(String username) async {
    await _httpService.init();

    final response = await _httpService.get('${_path}checkUsername/$username');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      
    } else {
      throw DHttpException(
        jsonDecode(response.body)['message'] ?? 'Something went wrong',
        response.statusCode,
      );
    }
  }
}

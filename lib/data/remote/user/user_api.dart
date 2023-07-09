import 'dart:convert';
import 'package:debt_tracker_mobile/domain/user/user.dart';
import 'package:debt_tracker_mobile/util/util.dart';

class UserApi {
  final HttpService _httpService = HttpService();
  final String _path = 'user/';

  Future<List<UserProfile>> getUsers() async {
    await _httpService.init();

    final response = await _httpService.get(_path);

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
        .map((profile) => UserProfile.fromJson(profile)).toList() ;
    } else {
      throw DHttpException(
          jsonDecode(response.body)['message'] ?? 'Something went wrong',
          response.statusCode);
    }
  }

  Future<User> getMe() async {
    await _httpService.init();

    final response = await _httpService.get('${_path}me');

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw DHttpException(
          jsonDecode(response.body)['message'] ?? 'Something went wrong',
          response.statusCode);
    }
  }

  Future<UserProfile> getUserById(String id) async {
    await _httpService.init();

    final response = await _httpService.get('${_path}id/$id');

    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      throw DHttpException(
          jsonDecode(response.body)['message'] ?? 'Something went wrong',
          response.statusCode);
    }
  }

  Future<UserProfile> getUserByUsername(String username) async {
    await _httpService.init();

    final response = await _httpService.get('${_path}id/$username');

    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      throw DHttpException(
          jsonDecode(response.body)['message'] ?? 'Something went wrong',
          response.statusCode);
    }
  }

  Future<List<UserProfile>> searchUsername(String username) async {
    await _httpService.init();

    final response = await _httpService.get('${_path}search/$username');

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
        .map((profile) => UserProfile.fromJson(profile)).toList() ;
    } else {
      throw DHttpException(
          jsonDecode(response.body)['message'] ?? 'Something went wrong',
          response.statusCode);
    }
  }

  Future<User> changeProfile(
      Map<String, String> changeProfileForm) async {
    await _httpService.init();

    final response =
        await _httpService.patch('${_path}edit', body: changeProfileForm);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw DHttpException(
          jsonDecode(response.body)['message'] ?? 'Something went wrong',
          response.statusCode);
    }
  }

  Future<Map<String, String>> changePassword(
      Map<String, String> changePasswordForm) async {
    await _httpService.init();

    final response =
        await _httpService.patch('${_path}changePassword', body: changePasswordForm);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw DHttpException(
        jsonDecode(response.body)['message'] ?? 'Something went wrong',
        response.statusCode,
      );
    }
  }

  Future<Map<String, String>> deleteAccount() async {
    await _httpService.init();

    final response = await _httpService.delete('${_path}delete');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw DHttpException(
        jsonDecode(response.body)['message'] ?? 'Something went wrong',
        response.statusCode
      );
    }
  }
}

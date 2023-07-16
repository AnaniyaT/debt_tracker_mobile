import 'dart:convert';
import 'package:debt_tracker_mobile/domain/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static Future<String> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken') ?? '';
  }

  static Future<void> setAuthToken(String authToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', authToken);
  }

  static Future<void> removeAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  static Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('authToken');
  }

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return User(
    //   id: '1234',
    //   name: 'John Doe',
    //   email: 'email@email.com',
    //   username: 'johndoe',
    //   amountOwed: 49,
    //   amountOwing: 0,
    //   profilePicture: 'https://picsum.photos/200/300',
    //   debts: [],
    //   history: []
    // );
    return User.fromJson(jsonDecode(prefs.getString('user') ?? '{}'));
  }

  static Future<void> setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  static Future<void> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  static Future<void> logout() async {
    await removeAuthToken();
    await removeUser();
  }
}
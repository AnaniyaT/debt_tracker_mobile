import 'dart:convert';

import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:http/http.dart' as http;
import 'package:debt_tracker_mobile/common/constants.dart';

class HttpService {
  String _token = '';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<bool> init() async {
    String token = await PreferenceService.getAuthToken();
    _token = token;
    _headers['authorization'] = 'Bearer $_token';

    return true;
  }

  Future<http.Response> get(String path) async {
    return await http.get(Uri.parse(Constants.baseUrl + path), headers: _headers);
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    return await http.post(Uri.parse(Constants.baseUrl + path), headers: _headers, body: jsonEncode(body));
  }

  Future<http.Response> put(String path, Map<String, dynamic> body) async {
    return await http.put(Uri.parse(Constants.baseUrl + path), headers: _headers, body: jsonEncode(body));
  }

  Future<http.Response> patch(String path, {Map<String, dynamic>? body = const {}}) async {
    print(path);
    return await http.patch(Uri.parse(Constants.baseUrl + path), headers: _headers, body: jsonEncode(body));
  }

  Future<http.Response> delete(String path) async {
    return await http.delete(Uri.parse(Constants.baseUrl + path), headers: _headers);
  }
}
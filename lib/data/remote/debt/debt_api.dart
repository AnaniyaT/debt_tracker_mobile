import 'dart:convert';
import 'package:debt_tracker_mobile/domain/debt/debt.dart';
import 'package:debt_tracker_mobile/util/util.dart';

class DebtApi {
  final HttpService _httpService = HttpService();
  final String _path = 'debt/';

  Future<List<Debt>> getDebts() async {
    await _httpService.init();

    final response = await _httpService.get(_path);

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
        .map((debt) => Debt.fromJson(debt)).toList();
    } else {
      throw DHttpException(
        jsonDecode(response.body)['message'] ?? 'Something went wrong',
        response.statusCode
      );
    }
  }

  Future<Debt> getDebtById(String id) async {
    await _httpService.init();
    
    final response = await _httpService.get('$_path$id');

    if (response.statusCode == 200) {
      return Debt.fromJson(jsonDecode(response.body));
    } else {
      throw DHttpException(
        jsonDecode(response.body)['message'] ?? 'Something went wrong',
        response.statusCode
      );
    }
  }

  Future<Debt> requestDebt(Map<String, dynamic> requestForm) async {
    await _httpService.init();
    
    final response = await _httpService.post('${_path}request', requestForm);

    if (response.statusCode == 201) {
      return Debt.fromJson(jsonDecode(response.body));
    } else {
      throw DHttpException(
        jsonDecode(response.body)['message'] ?? 'Something went wrong',
        response.statusCode
      );
    }
  }

  Future<Map<String, dynamic>> patchDebt(String path, String id) async {
    await _httpService.init();
    
    final response = await _httpService.patch('$_path$path$id');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw DHttpException(
        jsonDecode(response.body)['message'] ?? 'Something went wrong',
        response.statusCode
      );
    }
  }

  Future<Map<String, dynamic>> deleteDebt(String path, String id) async {
    await _httpService.init();
    
    final response = await _httpService.delete('$_path$path$id');

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
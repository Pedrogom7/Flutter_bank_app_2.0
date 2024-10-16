import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/account.dart';

class AccountService {
  static const String baseUrl = 'http://localhost:3001/accounts';

  Future<List<Account>> getAccounts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((json) => Account.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load accounts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load accounts: $e');
    }
  }

  Future<Account> createAccount(Account account) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(account.toJson()),
      );
      if (response.statusCode == 201) {
        return Account.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create account: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create account: $e');
    }
  }

  Future<void> updateAccount(Account account) async {
    final url = '$baseUrl/${account.id}';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(account.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update account: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update account: $e');
    }
  }

  Future<void> deleteAccount(String id) async {
    final url = '$baseUrl/$id';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete account: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }
}

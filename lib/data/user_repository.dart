import 'dart:convert';

import 'package:clean_riverpod/data/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final userRepositoryProvider = Provider((ref) => UserRepository());

class UserRepository {
  final _client = http.Client();

  Future<List<User>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );
      final jsonData = json.decode(response.body);
      final List<User> users = [];
      for (var user in jsonData) {
        users.add(User.fromJson(user));
      }
      return users;
    } catch (e) {
      throw Exception('Failed to load users');
    }
  }
}

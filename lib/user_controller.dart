import 'package:clean_riverpod/user_model.dart';
import 'package:clean_riverpod/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider((ref) => <User>[]);
final userControllerProvider = Provider(
  (ref) => UserController(
    userRepository: ref.read(userRepositoryProvider),
  ),
);

class UserController {
  final UserRepository _userRepository;
  UserController({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<void> getUsers(context) async {
    try {
      final res = await _userRepository.getUsers();
      context.read(userProvider).state = res;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

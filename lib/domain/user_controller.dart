import 'package:clean_riverpod/data/user_model.dart';
import 'package:clean_riverpod/data/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider((ref) => <User>[]);
final userControllerProvider = StateNotifierProvider<UserController,bool>(
  (ref) => UserController(
    userRepository: ref.read(userRepositoryProvider),
  ),
);

class UserController extends StateNotifier<bool>{
  final UserRepository _userRepository;
  UserController({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(false);

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

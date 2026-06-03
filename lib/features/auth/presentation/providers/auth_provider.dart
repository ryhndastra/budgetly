import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/services/auth_api_service.dart';
import '../../domain/entities/user.dart';

final authApiServiceProvider = Provider<AuthApiService>(
  (ref) => AuthApiService(),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read(authApiServiceProvider)),
);

const _userKey = 'current_user';

class AuthNotifier extends StateNotifier<User?> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(null);

  Future<void> login({required String email, required String password}) async {
    final user = await repository.login(email: email, password: password);

    state = user;

    await _saveUser(user);
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final user = await repository.register(
      fullName: fullName,
      email: email,
      password: password,
    );

    state = user;

    await _saveUser(user);
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_userKey);

    if (jsonString == null) {
      return;
    }

    state = User.fromJson(jsonDecode(jsonString));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userKey);

    state = null;
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(ref.read(authRepositoryProvider)),
);

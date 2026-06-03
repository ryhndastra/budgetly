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

class AuthNotifier extends StateNotifier<User?> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(null);

  Future<void> login({required String email, required String password}) async {
    final user = await repository.login(email: email, password: password);

    state = user;
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
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(ref.read(authRepositoryProvider)),
);

import '../../domain/entities/user.dart';
import '../services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService api;

  AuthRepository(this.api);

  Future<User> login({required String email, required String password}) async {
    final data = await api.login(email: email, password: password);

    return User.fromJson(data);
  }
}

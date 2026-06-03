import 'package:dio/dio.dart';

class TransactionApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8080/api'));

  Future<List<dynamic>> getTransactions(String userId) async {
    final response = await _dio.get(
      '/transactions',
      queryParameters: {'user_id': userId},
    );

    return response.data;
  }
}

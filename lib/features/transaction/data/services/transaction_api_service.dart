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

  Future<List<dynamic>> getCategories(String userId) async {
    final response = await _dio.get(
      '/categories',
      queryParameters: {'user_id': userId},
    );

    return response.data;
  }

  Future<void> createTransaction({
    required String userId,
    required String categoryId,
    required String title,
    required double amount,
    String? note,
    required String type,
  }) async {
    await _dio.post(
      '/transactions/',
      data: {
        'user_id': userId,
        'category_id': categoryId,
        'title': title,
        'amount': amount,
        'note': note,
        'type': type,
      },
    );
  }
}

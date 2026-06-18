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

  Future<void> createCategory({
    required String userId,
    required String name,
    required String icon,
    required String color,
    required String type,
  }) async {
    await _dio.post(
      '/categories/',
      data: {
        'user_id': userId,
        'name': name,
        'icon': icon,
        'color': color,
        'type': type,
      },
    );
  }

  Future<void> updateCategory({
    required String categoryId,
    required String name,
    required String icon,
    required String color,
    required String type,
  }) async {
    await _dio.put(
      '/categories/$categoryId',
      data: {'name': name, 'icon': icon, 'color': color, 'type': type},
    );
  }

  Future<void> deleteCategory(String categoryId) async {
    await _dio.delete('/categories/$categoryId');
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

  Future<void> updateTransaction({
    required String transactionId,
    required String categoryId,
    required String title,
    required double amount,
    String? note,
    required String type,
  }) async {
    await _dio.put(
      '/transactions/$transactionId',
      data: {
        'category_id': categoryId,
        'title': title,
        'amount': amount,
        'note': note,
        'type': type,
      },
    );
  }

  Future<void> deleteTransaction(String transactionId) async {
    await _dio.delete('/transactions/$transactionId');
  }
}

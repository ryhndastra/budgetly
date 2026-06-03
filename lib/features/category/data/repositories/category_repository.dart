import '../../domain/entities/category.dart';
import '../../../transaction/data/services/transaction_api_service.dart';

class CategoryRepository {
  final TransactionApiService api;

  CategoryRepository(this.api);

  Future<List<Category>> getAll(String userId) async {
    final data = await api.getCategories(userId);

    return data.map<Category>((json) => Category.fromJson(json)).toList();
  }
}

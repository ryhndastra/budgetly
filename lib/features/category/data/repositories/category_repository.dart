import '../../domain/entities/category.dart';
import '../../../transaction/data/services/transaction_api_service.dart';

class CategoryRepository {
  final TransactionApiService api;

  CategoryRepository(this.api);

  Future<List<Category>> getAll(String userId) async {
    final data = await api.getCategories(userId);

    return data.map<Category>((json) => Category.fromJson(json)).toList();
  }

  Future<void> create({
    required String userId,
    required String name,
    required String icon,
    required String color,
    required String type,
  }) {
    return api.createCategory(
      userId: userId,
      name: name,
      icon: icon,
      color: color,
      type: type,
    );
  }

  Future<void> update({
    required String categoryId,
    required String name,
    required String icon,
    required String color,
    required String type,
  }) {
    return api.updateCategory(
      categoryId: categoryId,
      name: name,
      icon: icon,
      color: color,
      type: type,
    );
  }

  Future<void> delete(String categoryId) {
    return api.deleteCategory(categoryId);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/category.dart';
import '../../data/repositories/category_repository.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(ref.read(transactionApiServiceProvider)),
);

class CategoryNotifier extends StateNotifier<List<Category>> {
  final CategoryRepository repository;

  CategoryNotifier(this.repository) : super([]);

  Future<void> loadCategories(String userId) async {
    state = await repository.getAll(userId);
  }

  Future<void> createCategory({
    required String userId,
    required String name,
    required String icon,
    required String color,
    required String type,
  }) async {
    await repository.create(
      userId: userId,
      name: name,
      icon: icon,
      color: color,
      type: type,
    );

    await loadCategories(userId);
  }

  Future<void> updateCategory({
    required String userId,
    required String categoryId,
    required String name,
    required String icon,
    required String color,
    required String type,
  }) async {
    await repository.update(
      categoryId: categoryId,
      name: name,
      icon: icon,
      color: color,
      type: type,
    );

    await loadCategories(userId);
  }

  Future<void> deleteCategory({
    required String userId,
    required String categoryId,
  }) async {
    await repository.delete(categoryId);

    await loadCategories(userId);
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>(
      (ref) => CategoryNotifier(ref.read(categoryRepositoryProvider)),
    );

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final user = ref.watch(authProvider);

  if (user == null) {
    return [];
  }

  final repository = ref.read(categoryRepositoryProvider);

  return repository.getAll(user.id);
});

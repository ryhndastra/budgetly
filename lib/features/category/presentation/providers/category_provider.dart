import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/category.dart';
import '../../data/repositories/category_repository.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(ref.read(transactionApiServiceProvider)),
);

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final user = ref.watch(authProvider);

  if (user == null) {
    return [];
  }

  final repository = ref.read(categoryRepositoryProvider);

  return repository.getAll(user.id);
});

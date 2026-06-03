import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/category.dart';
import '../../data/repositories/category_repository.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(ref.read(transactionApiServiceProvider)),
);

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repository = ref.read(categoryRepositoryProvider);

  return repository.getAll('aa2dcca5-f2bd-415e-8547-35fcd992db6c');
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/budget.dart';
import '../../data/repositories/budget_repository.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';

final budgetRepositoryProvider = Provider<BudgetRepository>(
  (ref) => BudgetRepository(ref.read(transactionApiServiceProvider)),
);

class BudgetNotifier extends StateNotifier<List<Budget>> {
  final BudgetRepository repository;

  BudgetNotifier(this.repository) : super([]);

  Future<void> loadBudgets(String userId) async {
    state = await repository.getAll(userId);
  }

  Future<void> createBudget({
    required String userId,
    required String categoryId,
    required double amount,
  }) async {
    await repository.create(
      userId: userId,
      categoryId: categoryId,
      amount: amount,
    );

    await loadBudgets(userId);
  }

  Future<void> updateBudget({
    required String userId,
    required String budgetId,
    required double amount,
  }) async {
    await repository.update(budgetId: budgetId, amount: amount);

    await loadBudgets(userId);
  }

  Future<void> deleteBudget({
    required String userId,
    required String budgetId,
  }) async {
    await repository.delete(budgetId);

    await loadBudgets(userId);
  }
}

final budgetProvider = StateNotifierProvider<BudgetNotifier, List<Budget>>(
  (ref) => BudgetNotifier(ref.read(budgetRepositoryProvider)),
);

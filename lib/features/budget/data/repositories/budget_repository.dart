import '../../domain/entities/budget.dart';
import '../../../transaction/data/services/transaction_api_service.dart';

class BudgetRepository {
  final TransactionApiService api;

  BudgetRepository(this.api);

  Future<List<Budget>> getAll(String userId) async {
    final data = await api.getBudgets(userId);

    return data.map<Budget>((json) => Budget.fromJson(json)).toList();
  }

  Future<void> create({
    required String userId,
    required String categoryId,
    required double amount,
  }) {
    return api.createBudget(
      userId: userId,
      categoryId: categoryId,
      amount: amount,
    );
  }

  Future<void> update({required String budgetId, required double amount}) {
    return api.updateBudget(budgetId: budgetId, amount: amount);
  }

  Future<void> delete(String budgetId) {
    return api.deleteBudget(budgetId);
  }
}

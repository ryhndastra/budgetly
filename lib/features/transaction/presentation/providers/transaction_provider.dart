import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/transaction_repository.dart';
import '../../data/services/transaction_api_service.dart';
import '../../domain/entities/transaction.dart';

final transactionApiServiceProvider = Provider<TransactionApiService>(
  (ref) => TransactionApiService(),
);

final transactionRepositoryProvider = Provider<TransactionRepository>(
  (ref) => TransactionRepository(ref.read(transactionApiServiceProvider)),
);

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  final TransactionRepository repository;

  TransactionNotifier(this.repository) : super([]);

  Future<void> loadTransactions(String userId) async {
    state = await repository.getAll(userId);
  }

  Future<void> deleteTransaction({
    required String transactionId,
    required String userId,
  }) async {
    await repository.delete(transactionId);

    await loadTransactions(userId);
  }

  Future<void> updateTransaction({
    required String userId,
    required String transactionId,
    required String categoryId,
    required String title,
    required double amount,
    String? note,
    required String type,
  }) async {
    await repository.update(
      transactionId: transactionId,
      categoryId: categoryId,
      title: title,
      amount: amount,
      note: note,
      type: type,
    );

    await loadTransactions(userId);
  }

  void addTransaction(Transaction transaction) {
    state = [transaction, ...state];
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>(
      (ref) => TransactionNotifier(ref.read(transactionRepositoryProvider)),
    );

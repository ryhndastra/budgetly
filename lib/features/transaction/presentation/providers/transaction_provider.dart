import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/transaction.dart';
import '../../data/repositories/transaction_repository.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>(
  (ref) => TransactionRepository(),
);

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  final TransactionRepository repository;

  TransactionNotifier(this.repository) : super(repository.getAll());

  void addTransaction(Transaction transaction) {
    repository.add(transaction);

    state = [...repository.getAll()];
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>(
      (ref) => TransactionNotifier(ref.read(transactionRepositoryProvider)),
    );

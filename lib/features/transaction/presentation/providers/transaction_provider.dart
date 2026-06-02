import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/enums/transaction_type.dart';

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier()
    : super([
        Transaction(
          id: '1',
          title: 'Gaji Bulanan',
          amount: 15000000,
          category: 'Gaji',
          type: TransactionType.income,
          createdAt: DateTime.now(),
        ),

        Transaction(
          id: '2',
          title: 'Makan Siang',
          amount: 50000,
          category: 'Makanan',
          type: TransactionType.expense,
          createdAt: DateTime.now(),
        ),
      ]);

  void addTransaction(Transaction transaction) {
    state = [transaction, ...state];
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>(
      (ref) => TransactionNotifier(),
    );

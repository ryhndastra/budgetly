import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/transaction_provider.dart';
import '../../domain/enums/transaction_type.dart';
import 'transaction_tile.dart';

class TransactionList extends ConsumerWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    return ListView.separated(
      itemCount: transactions.length,

      separatorBuilder: (_, _) => const SizedBox(height: 12),

      itemBuilder: (context, index) {
        final transaction = transactions[index];

        return TransactionTile(
          isIncome: transaction.type == TransactionType.income,

          title: transaction.title,

          amount: transaction.amount,

          date: 'Hari ini',
        );
      },
    );
  }
}

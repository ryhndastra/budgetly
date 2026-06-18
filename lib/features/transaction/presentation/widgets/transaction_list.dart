import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/add_transaction_page.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/transaction_provider.dart';
import '../../domain/enums/transaction_type.dart';
import 'transaction_tile.dart';

class TransactionList extends ConsumerWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    final user = ref.watch(authProvider);

    return ListView.separated(
      itemCount: transactions.length,

      separatorBuilder: (_, _) => const SizedBox(height: 12),

      itemBuilder: (context, index) {
        final transaction = transactions[index];

        return TransactionTile(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddTransactionPage(
                  type: transaction.type,
                  transaction: transaction,
                ),
              ),
            );

            if (result == true && user != null) {
              await ref
                  .read(transactionProvider.notifier)
                  .loadTransactions(user.id);
            }
          },
          isIncome: transaction.type == TransactionType.income,
          title: transaction.title,
          amount: transaction.amount,
          date: 'Hari ini',

          onLongPress: () async {
            if (user == null) return;

            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Hapus Transaksi'),
                  content: const Text('Yakin ingin menghapus transaksi ini?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Batal'),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Hapus'),
                    ),
                  ],
                );
              },
            );

            if (confirm != true) return;

            await ref
                .read(transactionProvider.notifier)
                .deleteTransaction(
                  transactionId: transaction.id,
                  userId: user.id,
                );
          },
        );
      },
    );
  }
}

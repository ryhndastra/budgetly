import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../transaction/domain/enums/transaction_type.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';

class RecentTransactionCard extends ConsumerWidget {
  const RecentTransactionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider).take(3).toList();

    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaksi Terbaru',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 20),

          ...List.generate(transactions.length, (index) {
            final transaction = transactions[index];

            return Column(
              children: [
                _transaction(
                  icon: transaction.type == TransactionType.income
                      ? Icons.payments_rounded
                      : Icons.shopping_bag_rounded,

                  title: transaction.title,

                  amount:
                      '${transaction.type == TransactionType.income ? '+' : '-'} ${currency.format(transaction.amount)}',
                ),

                if (index != transactions.length - 1)
                  Divider(color: AppColors.border),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _transaction({
    required IconData icon,
    required String title,
    required String amount,
  }) {
    return Row(
      children: [
        CircleAvatar(radius: 20, child: Icon(icon, size: 20)),

        const SizedBox(width: 12),

        Expanded(child: Text(title)),

        Text(amount),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/app_card.dart';
import '../../../budget/presentation/providers/budget_provider.dart';
import '../../../category/presentation/providers/category_provider.dart';
import '../../../transaction/domain/enums/transaction_type.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';

class BudgetProgressCard extends ConsumerWidget {
  const BudgetProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgets = ref.watch(budgetProvider);
    final categories = ref.watch(categoryProvider);
    final transactions = ref.watch(transactionProvider);

    if (budgets.isEmpty || categories.isEmpty) {
      return const SizedBox.shrink();
    }

    final budget = budgets.first;

    final category = categories.firstWhere(
      (c) => c.id == budget.categoryId,
      orElse: () => categories.first,
    );

    final spent = transactions
        .where(
          (t) =>
              t.categoryId == budget.categoryId &&
              t.type == TransactionType.expense,
        )
        .fold<double>(0, (sum, item) => sum + item.amount);

    final progress = budget.amount == 0
        ? 0.0
        : (spent / budget.amount).clamp(0.0, 1.0);

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
            'Progress Anggaran',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const Icon(Icons.account_balance_wallet),

              const SizedBox(width: 8),

              Text(
                category.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: 12),

          LinearProgressIndicator(value: progress),

          const SizedBox(height: 8),

          Text('${currency.format(spent)} / ${currency.format(budget.amount)}'),
        ],
      ),
    );
  }
}

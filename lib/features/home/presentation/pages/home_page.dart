import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../transaction/domain/enums/transaction_type.dart';
import '../../../transaction/presentation/providers/transaction_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/budget_progress_card.dart';
import '../widgets/goal_progress_card.dart';
import '../widgets/recent_transaction_card.dart';
import '../widgets/summary_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    final income = transactions
        .where((t) => t.type == TransactionType.income)
        .fold<double>(0, (sum, t) => sum + t.amount);

    final expense = transactions
        .where((t) => t.type == TransactionType.expense)
        .fold<double>(0, (sum, t) => sum + t.amount);

    final balance = income - expense;

    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Sho',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            Text(
              'Kelola keuanganmu dengan lebih cerdas.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            BalanceCard(balance: currency.format(balance)),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Pemasukan',
                    amount: currency.format(income),
                    icon: Icons.south_rounded,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SummaryCard(
                    title: 'Pengeluaran',
                    amount: currency.format(expense),
                    icon: Icons.north_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const RecentTransactionCard(),

            const SizedBox(height: 20),

            const BudgetProgressCard(),

            const SizedBox(height: 20),

            const GoalProgressCard(),
          ],
        ),
      ),
    );
  }
}

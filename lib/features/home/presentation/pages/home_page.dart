import 'package:flutter/material.dart';

import '../widgets/balance_card.dart';
import '../widgets/budget_progress_card.dart';
import '../widgets/goal_progress_card.dart';
import '../widgets/recent_transaction_card.dart';
import '../widgets/summary_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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

            const BalanceCard(),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Pemasukan',
                    amount: 'Rp 15.000.000',
                    icon: Icons.south_rounded,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SummaryCard(
                    title: 'Pengeluaran',
                    amount: 'Rp 2.500.000',
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/budget_provider.dart';

class BudgetPage extends ConsumerStatefulWidget {
  const BudgetPage({super.key});

  @override
  ConsumerState<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends ConsumerState<BudgetPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final user = ref.read(authProvider);

      if (user == null) {
        return;
      }

      await ref.read(budgetProvider.notifier).loadBudgets(user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final budgets = ref.watch(budgetProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Budget')),

      body: ListView.builder(
        padding: const EdgeInsets.all(24),

        itemCount: budgets.length,

        itemBuilder: (context, index) {
          final budget = budgets[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),

            child: ListTile(
              title: Text(budget.categoryId),

              subtitle: Text('Rp ${budget.amount.toInt()}'),
            ),
          );
        },
      ),
    );
  }
}

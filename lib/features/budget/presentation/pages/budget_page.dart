import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/presentation/providers/category_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/budget_provider.dart';
import '../widgets/budget_tile.dart';
import '../widgets/budget_form_sheet.dart';

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
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Budget')),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const BudgetFormSheet(),
          );
        },

        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(24),

        itemCount: budgets.length,

        itemBuilder: (context, index) {
          final budget = budgets[index];

          final category = categories.firstWhere(
            (c) => c.id == budget.categoryId,
          );

          return BudgetTile(
            categoryName: category.name,
            amount: budget.amount,

            onEdit: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => BudgetFormSheet(budget: budget),
              );
            },

            onDelete: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Hapus Budget'),

                    content: Text(
                      'Yakin ingin menghapus budget ${category.name}?',
                    ),

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

              if (confirmed != true) {
                return;
              }

              final user = ref.read(authProvider);

              if (user == null) {
                return;
              }

              await ref
                  .read(budgetProvider.notifier)
                  .deleteBudget(userId: user.id, budgetId: budget.id);
            },
          );
        },
      ),
    );
  }
}

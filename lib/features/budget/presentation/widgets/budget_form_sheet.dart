import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/budget.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../category/presentation/providers/category_provider.dart';
import '../providers/budget_provider.dart';

class BudgetFormSheet extends ConsumerStatefulWidget {
  final Budget? budget;

  const BudgetFormSheet({super.key, this.budget});

  @override
  ConsumerState<BudgetFormSheet> createState() => _BudgetFormSheetState();
}

class _BudgetFormSheetState extends ConsumerState<BudgetFormSheet> {
  final amountController = TextEditingController();

  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();

    if (widget.budget != null) {
      amountController.text = widget.budget!.amount.toInt().toString();

      selectedCategoryId = widget.budget!.categoryId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);

    final expenseCategories = ref
        .watch(categoryProvider)
        .where((c) => c.type == 'expense')
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.budget == null ? 'Tambah Budget' : 'Edit Budget',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          DropdownButtonFormField<String>(
            initialValue: selectedCategoryId,

            decoration: const InputDecoration(
              labelText: 'Kategori',
              border: OutlineInputBorder(),
            ),

            items: expenseCategories.map((category) {
              return DropdownMenuItem<String>(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),

            onChanged: widget.budget != null
                ? null
                : (value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                  },
          ),

          const SizedBox(height: 20),

          TextField(
            controller: amountController,

            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              labelText: 'Nominal Budget',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,

            child: FilledButton(
              onPressed: () async {
                if (user == null) {
                  return;
                }

                if (selectedCategoryId == null) {
                  return;
                }

                if (amountController.text.trim().isEmpty) {
                  return;
                }

                final amount = double.parse(amountController.text.trim());

                if (widget.budget == null) {
                  await ref
                      .read(budgetProvider.notifier)
                      .createBudget(
                        userId: user.id,
                        categoryId: selectedCategoryId!,
                        amount: amount,
                      );
                } else {
                  await ref
                      .read(budgetProvider.notifier)
                      .updateBudget(
                        userId: user.id,
                        budgetId: widget.budget!.id,
                        amount: amount,
                      );
                }

                if (!context.mounted) {
                  return;
                }

                Navigator.pop(context);
              },

              child: Text(widget.budget == null ? 'Simpan' : 'Update'),
            ),
          ),
        ],
      ),
    );
  }
}

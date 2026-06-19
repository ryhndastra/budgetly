import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetTile extends StatelessWidget {
  final String categoryName;
  final double amount;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BudgetTile({
    super.key,
    required this.categoryName,
    required this.amount,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.account_balance_wallet),

        title: Text(
          categoryName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),

        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              onEdit();
            }

            if (value == 'delete') {
              onDelete();
            }
          },

          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit')),

            PopupMenuItem(value: 'delete', child: Text('Hapus')),
          ],
        ),

        subtitle: Text(currency.format(amount)),
      ),
    );
  }
}

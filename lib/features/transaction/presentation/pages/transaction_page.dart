import 'package:flutter/material.dart';

import '../widgets/add_transaction_sheet.dart';
import '../widgets/transaction_list.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTransactionSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transaksi',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text('Kelola pemasukan dan pengeluaranmu.'),

              const SizedBox(height: 24),

              const Expanded(child: TransactionList()),
            ],
          ),
        ),
      ),
    );
  }
}

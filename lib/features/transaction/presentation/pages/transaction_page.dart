import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/transaction_provider.dart';
import '../widgets/add_transaction_sheet.dart';
import '../widgets/transaction_list.dart';

class TransactionPage extends ConsumerStatefulWidget {
  const TransactionPage({super.key});

  @override
  ConsumerState<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends ConsumerState<TransactionPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(transactionProvider.notifier)
          .loadTransactions('aa2dcca5-f2bd-415e-8547-35fcd992db6c');
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionProvider);

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

              Text('Total transaksi: ${transactions.length}'),

              const SizedBox(height: 12),

              const Expanded(child: TransactionList()),
            ],
          ),
        ),
      ),
    );
  }
}

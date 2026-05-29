import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/enums/transaction_type.dart';
import '../../../../core/widgets/app_card.dart';

class AddTransactionSheet extends StatelessWidget {
  const AddTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tambah Transaksi',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);

                    context.push(
                      '/add-transaction',
                      extra: TransactionType.income,
                    );
                  },
                  child: AppCard(
                    child: Column(
                      children: [
                        Icon(Icons.south_rounded),
                        SizedBox(height: 12),
                        Text('Pemasukan'),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);

                    context.push(
                      '/add-transaction',
                      extra: TransactionType.expense,
                    );
                  },
                  child: AppCard(
                    child: Column(
                      children: [
                        Icon(Icons.north_rounded),
                        SizedBox(height: 12),
                        Text('Pengeluaran'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

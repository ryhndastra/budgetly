import 'package:flutter/material.dart';

import '../../../../core/widgets/app_card.dart';

class BudgetProgressCard extends StatelessWidget {
  const BudgetProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Anggaran',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 20),

          const Text('Makanan'),

          const SizedBox(height: 8),

          const LinearProgressIndicator(value: 0.75),

          const SizedBox(height: 8),

          const Text('Rp 1.500.000 / Rp 2.000.000'),
        ],
      ),
    );
  }
}

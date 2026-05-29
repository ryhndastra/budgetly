import 'package:flutter/material.dart';

import '../../../../core/widgets/app_card.dart';

class GoalProgressCard extends StatelessWidget {
  const GoalProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Target Keuangan',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 20),

          const Text(
            'Laptop Baru',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          const LinearProgressIndicator(value: 0.53),

          const SizedBox(height: 12),

          const Text('Rp 8.000.000 / Rp 15.000.000'),
        ],
      ),
    );
  }
}

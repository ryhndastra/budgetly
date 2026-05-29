import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';

class RecentTransactionCard extends StatelessWidget {
  const RecentTransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaksi Terbaru',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 20),

          _transaction(
            icon: Icons.fastfood_rounded,
            title: 'Makan Siang',
            amount: '- Rp 45.000',
          ),

          Divider(color: AppColors.border),

          _transaction(
            icon: Icons.coffee_rounded,
            title: 'Kopi Kenangan',
            amount: '- Rp 32.000',
          ),

          Divider(color: AppColors.border),

          _transaction(
            icon: Icons.payments_rounded,
            title: 'Gaji Bulanan',
            amount: '+ Rp 8.000.000',
          ),
        ],
      ),
    );
  }

  Widget _transaction({
    required IconData icon,
    required String title,
    required String amount,
  }) {
    return Row(
      children: [
        CircleAvatar(radius: 20, child: Icon(icon, size: 20)),

        const SizedBox(width: 12),

        Expanded(child: Text(title)),

        Text(amount),
      ],
    );
  }
}

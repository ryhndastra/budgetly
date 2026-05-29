import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';

class TransactionTile extends StatelessWidget {
  final bool isIncome;
  final String title;
  final String amount;
  final String date;

  const TransactionTile({
    super.key,
    required this.isIncome,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isIncome
                ? AppColors.success.withValues(alpha: 0.15)
                : AppColors.danger.withValues(alpha: 0.15),

            child: Icon(
              isIncome ? Icons.south_rounded : Icons.north_rounded,
              color: isIncome ? AppColors.success : AppColors.danger,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 4),

                Text(date),
              ],
            ),
          ),

          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isIncome ? AppColors.success : AppColors.danger,
            ),
          ),
        ],
      ),
    );
  }
}

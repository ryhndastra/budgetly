import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final bool isIncome;
  final String title;
  final double amount;
  final String date;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const TransactionTile({
    super.key,
    required this.isIncome,
    required this.title,
    required this.amount,
    required this.date,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AppCard(
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

            Text(currency.format(amount)),
          ],
        ),
      ),
    );
  }
}

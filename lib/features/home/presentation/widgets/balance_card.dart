import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String balance;

  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A5568), Color(0xFF0F738D)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Saldo Total', style: TextStyle(color: Colors.white70)),

            const Spacer(),

            Text(
              balance,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            const Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 18,
                  color: Colors.white,
                ),

                SizedBox(width: 6),

                Text(
                  'Dihitung dari transaksi',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

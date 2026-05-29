import 'package:flutter/material.dart';

import '../../../../core/widgets/app_card.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,

      separatorBuilder: (_, _) => const SizedBox(height: 12),

      itemBuilder: (context, index) {
        return AppCard(
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  index.isEven ? Icons.arrow_downward : Icons.arrow_upward,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(index.isEven ? 'Gaji Bulanan' : 'Makan Siang'),

                    const SizedBox(height: 4),

                    Text('Hari ini', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),

              Text(
                index.isEven ? '+ Rp 8.000.000' : '- Rp 45.000',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}

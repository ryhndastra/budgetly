import '../enums/transaction_type.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final String categoryId;
  final String? note;
  final TransactionType type;
  final DateTime createdAt;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    this.note,
    required this.type,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      categoryId: json['category_id'],
      note: json['note'],
      type: json['type'] == 'income'
          ? TransactionType.income
          : TransactionType.expense,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

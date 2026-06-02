import '../enums/transaction_type.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final String category;
  final String? note;
  final TransactionType type;
  final DateTime createdAt;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    this.note,
    required this.type,
    required this.createdAt,
  });
}

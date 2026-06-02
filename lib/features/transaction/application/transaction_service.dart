import '../domain/entities/transaction.dart';
import '../domain/enums/transaction_type.dart';

class TransactionService {
  const TransactionService();

  Transaction createTransaction({
    required String title,
    required double amount,
    required String category,
    String? note,
    required TransactionType type,
  }) {
    return Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: category,
      note: note,
      type: type,
      createdAt: DateTime.now(),
    );
  }
}

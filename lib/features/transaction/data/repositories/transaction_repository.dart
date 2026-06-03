import '../../domain/entities/transaction.dart';

class TransactionRepository {
  final List<Transaction> _transactions = [];

  List<Transaction> getAll() {
    return _transactions;
  }

  void add(Transaction transaction) {
    _transactions.insert(0, transaction);
  }
}

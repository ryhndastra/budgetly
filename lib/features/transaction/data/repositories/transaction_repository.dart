import '../../domain/entities/transaction.dart';
import '../services/transaction_api_service.dart';

class TransactionRepository {
  final TransactionApiService api;

  TransactionRepository(this.api);

  Future<List<Transaction>> getAll(String userId) async {
    final data = await api.getTransactions(userId);

    return data.map<Transaction>((json) => Transaction.fromJson(json)).toList();
  }
}

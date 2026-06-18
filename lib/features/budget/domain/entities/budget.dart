class Budget {
  final String id;
  final String userId;
  final String categoryId;
  final double amount;
  final DateTime createdAt;

  const Budget({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.amount,
    required this.createdAt,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      amount: (json['amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

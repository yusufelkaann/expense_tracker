class Income {
  final String id;
  final double amount;
  final DateTime date;

  Income({required this.id, required this.amount, required this.date});

  factory Income.fromFirestore(Map<String, dynamic> data, String id) {
    final amount = (data['amount'] is double) ? data['amount'] : double.tryParse(data['amount'].toString()) ?? 0.0;
    return Income(
      id: id,
      amount:amount,
      date: DateTime.parse(data['date'] as String), 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
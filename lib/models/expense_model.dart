// models/expense.dart
class Expense {
  final String id;
  final DateTime date; // Assuming date is in a suitable format
  final double amount; // Change to double
  final String type;

  Expense({required this.id, required this.date, required this.amount, required this.type});

  factory Expense.fromFirestore(Map<String, dynamic> data, String id) {
    // Ensure amount is always treated as a double
    final amount = (data['amount'] is double) ? data['amount'] : double.tryParse(data['amount'].toString()) ?? 0.0;

    return Expense(
      id: id,
      date: DateTime.parse(data['date'] as String),
      amount: amount,
      type: data['type'] as String,
    );
  }



  
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'type': type,
      'date': date.toIso8601String(),
    };
  }

  
  
}

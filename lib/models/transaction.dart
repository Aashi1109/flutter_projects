class Transaction {
  final String name;
  final DateTime date;
  final double amount;
  String? id;

  Transaction(
      {required this.amount, required this.date, required this.name, this.id});
}

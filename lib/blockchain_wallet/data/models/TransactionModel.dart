class Transaction {
  final String id;
  final DateTime date;
  final String sender;
  final String receiver;
  final double amount;

  Transaction({
    required this.id,
    required this.date,
    required this.sender,
    required this.receiver,
    required this.amount,
  });
}

class Debt {
  final String id;
  final String lender;
  final String borrower;
  final int amount;
  final String? description;
  final DateTime requestedDate;
  final DateTime? approvedDate;
  final DateTime? declinedDate;
  final DateTime? paidDate;
  final bool paid;
  final String status;

  const Debt({
    required this.id,
    required this.lender,
    required this.borrower,
    required this.amount,
    this.description,
    required this.requestedDate,
    this.approvedDate,
    this.declinedDate,
    this.paidDate,
    required this.paid,
    required this.status,
  });

  factory Debt.fromJson(Map<String, dynamic> json) {
    return Debt(
      id: json['_id'],
      lender: json['lender'],
      borrower: json['borrower'],
      amount: json['amount'],
      description: json['description'],
      requestedDate: DateTime.parse(json['requestedDate']),
      approvedDate: json['approvedDate'] != null ? DateTime.parse(json['approvedDate']) : null,
      declinedDate: json['declinedDate'] != null ? DateTime.parse(json['declinedDate']) : null,
      paidDate: json['paidDate'] != null ? DateTime.parse(json['paidDate']) : null,
      paid: json['paid'],
      status: json['status'],
    );
  }
}
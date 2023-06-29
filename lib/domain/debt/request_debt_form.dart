class RequestDebtForm {
  final String lenderId;
  final int amount;
  final String? description;

  RequestDebtForm({
    required this.lenderId,
    required this.amount,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'lenderId': lenderId,
      'amount': amount,
      'description': description
    };
  }
}
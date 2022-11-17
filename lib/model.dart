class Payment {
  double totalSum;
  double paidSum;
  String reason;
  String address;
  String? iban;

  static int currentId = 0;

  Payment(this.totalSum, this.paidSum, this.reason, this.address, this.iban);

  @override
  String toString() {
    return reason;
  }

  String reasonToString() {
    return reason;
  }

  String sumsToString() {
    return '$paidSum \$ / $totalSum \$';
  }
}

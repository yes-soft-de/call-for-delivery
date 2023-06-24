class Data {
  int? id;
  int? subscriptionCostLimit;
  bool? openingPackagePaymentHasPassed;

  Data({
    this.id,
    this.subscriptionCostLimit,
    this.openingPackagePaymentHasPassed,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        subscriptionCostLimit: json['subscriptionCostLimit'] as int?,
        openingPackagePaymentHasPassed: json['openingPackagePaymentHasPassed'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subscriptionCostLimit': subscriptionCostLimit,
      };
}

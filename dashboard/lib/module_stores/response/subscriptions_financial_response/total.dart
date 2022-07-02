class Total {
  num? sumPayments;
  num? packageCost;
  bool? advancePayment;
  num? total;
  num? captainOfferPrice;
  Total(
      {this.sumPayments,
      this.packageCost,
      this.advancePayment,
      this.total,
      this.captainOfferPrice});

  factory Total.fromJson(Map<String, dynamic> json) => Total(
      sumPayments: json['sumPayments'] as num?,
      packageCost: json['packageCost'] as num?,
      advancePayment: json['advancePayment'] as bool?,
      total: json['total'] as num?,
      captainOfferPrice: json['captainOfferPrice'] as num?);

  Map<String, dynamic> toJson() => {
        'sumPayments': sumPayments,
        'packageCost': packageCost,
        'advancePayment': advancePayment,
        'total': total,
      };
}

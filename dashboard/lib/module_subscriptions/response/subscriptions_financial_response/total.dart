class Total {
  num? totalDistanceExtra;
  num? extraCost;
  num? sumPayments;
  num? packageCost;
  dynamic? advancePayment;
  num? total;
  num? captainOfferPrice;
  num? requiredToPay;
  Total(
      {this.sumPayments,
      this.packageCost,
      this.advancePayment,
      this.total,
      this.captainOfferPrice,
      this.requiredToPay,
      this.extraCost,
      this.totalDistanceExtra});

  factory Total.fromJson(Map<String, dynamic> json) => Total(
      sumPayments: json['sumPayments'] as num?,
      totalDistanceExtra: json['totalDistanceExtra'] as num?,
      extraCost: json['extraCost'] as num?,
      packageCost: json['packageCost'] as num?,
      requiredToPay: json['requiredToPay'] as num?,
      advancePayment: json['advancePayment'] as dynamic,
      total: json['total'] as num?,
      captainOfferPrice: json['captainOfferPrice'] as num?);

  Map<String, dynamic> toJson() => {
        'sumPayments': sumPayments,
        'packageCost': packageCost,
        'advancePayment': advancePayment,
        'total': total,
      };
}

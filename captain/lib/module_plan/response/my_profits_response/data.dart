class Data {
  int? todayOrdersCount;
  num? todayFinancialAmount;
  int? sinceLastPaymentOrdersCount;
  num? sinceLastPaymentFinancialAmount;
  num? sinceLastPaymentCashOrderAmount;
  num? sinceLastPaymentRemainFinancialAmount;
  int? captainFinancialSystemType;
  num? openingOrderCost;
  num? firstSliceLimit;
  num? firstSliceCost;
  num? secondSliceFromLimit;
  num? secondSliceToLimit;
  num? secondSliceOneKilometerCost;
  num? thirdSliceFromLimit;
  num? thirdSliceToLimit;
  num? thirdSliceOneKilometerCost;

  Data({
    this.todayOrdersCount,
    this.todayFinancialAmount,
    this.sinceLastPaymentOrdersCount,
    this.sinceLastPaymentFinancialAmount,
    this.sinceLastPaymentCashOrderAmount,
    this.sinceLastPaymentRemainFinancialAmount,
    this.captainFinancialSystemType,
    this.openingOrderCost,
    this.firstSliceLimit,
    this.firstSliceCost,
    this.secondSliceFromLimit,
    this.secondSliceToLimit,
    this.secondSliceOneKilometerCost,
    this.thirdSliceFromLimit,
    this.thirdSliceToLimit,
    this.thirdSliceOneKilometerCost,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        todayOrdersCount: json['todayOrdersCount'] as int?,
        todayFinancialAmount: json['todayFinancialAmount'] as int?,
        sinceLastPaymentOrdersCount:
            json['sinceLastPaymentOrdersCount'] as int?,
        sinceLastPaymentFinancialAmount:
            json['sinceLastPaymentFinancialAmount'] as int?,
        sinceLastPaymentCashOrderAmount:
            json['sinceLastPaymentCashOrderAmount'] as int?,
        sinceLastPaymentRemainFinancialAmount:
            json['sinceLastPaymentRemainFinancialAmount'] as int?,
        captainFinancialSystemType: json['captainFinancialSystemType'] as int?,
        openingOrderCost: json['openingOrderCost'] as int?,
        firstSliceLimit: json['firstSliceLimit'] as int?,
        firstSliceCost: (json['firstSliceCost'] as num?)?.toDouble(),
        secondSliceFromLimit: json['secondSliceFromLimit'] as int?,
        secondSliceToLimit: json['secondSliceToLimit'] as int?,
        secondSliceOneKilometerCost:
            (json['secondSliceOneKilometerCost'] as num?)?.toDouble(),
        thirdSliceFromLimit: json['thirdSliceFromLimit'] as int?,
        thirdSliceToLimit: json['thirdSliceToLimit'] as dynamic,
        thirdSliceOneKilometerCost:
            (json['thirdSliceOneKilometerCost'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'todayOrdersCount': todayOrdersCount,
        'todayFinancialAmount': todayFinancialAmount,
        'sinceLastPaymentOrdersCount': sinceLastPaymentOrdersCount,
        'sinceLastPaymentFinancialAmount': sinceLastPaymentFinancialAmount,
        'sinceLastPaymentCashOrderAmount': sinceLastPaymentCashOrderAmount,
        'sinceLastPaymentRemainFinancialAmount':
            sinceLastPaymentRemainFinancialAmount,
        'captainFinancialSystemType': captainFinancialSystemType,
        'openingOrderCost': openingOrderCost,
        'firstSliceLimit': firstSliceLimit,
        'firstSliceCost': firstSliceCost,
        'secondSliceFromLimit': secondSliceFromLimit,
        'secondSliceToLimit': secondSliceToLimit,
        'secondSliceOneKilometerCost': secondSliceOneKilometerCost,
        'thirdSliceFromLimit': thirdSliceFromLimit,
        'thirdSliceToLimit': thirdSliceToLimit,
        'thirdSliceOneKilometerCost': thirdSliceOneKilometerCost,
      };
}

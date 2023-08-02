class Data {
  num? todayOrdersCount;
  num? todayFinancialAmount;
  num? sinceLastPaymentOrdersCount;
  num? sinceLastPaymentFinancialAmount;
  num? sinceLastPaymentCashOrderAmount;
  num? sinceLastPaymentRemainFinancialAmount;
  num? captainFinancialSystemType;
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
        todayOrdersCount: json['todayOrdersCount'] as num?,
        sinceLastPaymentOrdersCount:
            json['sinceLastPaymentOrdersCount'] as num?,
        captainFinancialSystemType: json['captainFinancialSystemType'] as num?,
        todayFinancialAmount: json['todayFinancialAmount'] as num?,
        sinceLastPaymentFinancialAmount:
            json['sinceLastPaymentFinancialAmount'] as num?,
        sinceLastPaymentCashOrderAmount:
            json['sinceLastPaymentCashOrderAmount'] as num?,
        sinceLastPaymentRemainFinancialAmount:
            json['sinceLastPaymentRemainFinancialAmount'] as num?,
        openingOrderCost: json['openingOrderCost'] as num?,
        firstSliceLimit: json['firstSliceLimit'] as num?,
        firstSliceCost: json['firstSliceCost'] as num?,
        secondSliceFromLimit: json['secondSliceFromLimit'] as num?,
        secondSliceToLimit: json['secondSliceToLimit'] as num?,
        secondSliceOneKilometerCost:
            json['secondSliceOneKilometerCost'] as num?,
        thirdSliceFromLimit: json['thirdSliceFromLimit'] as num?,
        thirdSliceToLimit: json['thirdSliceToLimit'] as num?,
        thirdSliceOneKilometerCost: json['thirdSliceOneKilometerCost'] as num?,
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

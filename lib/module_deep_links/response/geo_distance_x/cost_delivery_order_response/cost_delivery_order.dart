class CostDeliveryOrder {
  num? extraDistance;
  num? orderDeliveryCost;
  num? extraOrderDeliveryCost;
  num? total;

  CostDeliveryOrder({
    this.extraDistance,
    this.orderDeliveryCost,
    this.extraOrderDeliveryCost,
    this.total,
  });

  factory CostDeliveryOrder.fromJson(Map<String, dynamic> json) {
    return CostDeliveryOrder(
      extraDistance: (json['extraDistance'] as num?),
      orderDeliveryCost: json['orderDeliveryCost'] as num?,
      extraOrderDeliveryCost: json['extraOrderDeliveryCost'] as num?,
      total: json['total'] as num?,
    );
  }

  Map<String, dynamic> toJson() => {
        'extraDistance': extraDistance,
        'orderDeliveryCost': orderDeliveryCost,
        'extraOrderDeliveryCost': extraOrderDeliveryCost,
        'total': total,
      };
}

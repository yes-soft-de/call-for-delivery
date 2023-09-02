import 'package:c4d/module_orders/response/orders_response/datum.dart';

class Data {
  List<DatumOrder>? pendingOrders;
  List<DatumOrder>? deliveredOrders;
  List<DatumOrder>? notDeliveredOrders;
  num? totalOrderCount;
  num? notDeliveredOrdersCount;
  num? deliveredOrdersCount;
  num? pendingOrdersCount;

  Data(
      {this.pendingOrders,
      this.deliveredOrders,
      this.notDeliveredOrders,
      this.totalOrderCount,
      this.deliveredOrdersCount,
      this.notDeliveredOrdersCount,
      this.pendingOrdersCount});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalOrderCount: json['totalOrderCount'] as num?,
        pendingOrdersCount: json['pendingOrdersCount'] as num?,
        deliveredOrdersCount: json['hiddenOrdersCount'] as num?,
        notDeliveredOrdersCount: json['notDeliveredOrdersCount'] as num?,
        pendingOrders: (json['pendingOrders'] as List<dynamic>?)
            ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
        deliveredOrders: (json['deliveredOrders'] as List<dynamic>?)
            ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
        notDeliveredOrders: (json['notDeliveredOrders'] as List<dynamic>?)
            ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'pendingOrders': pendingOrders,
        'deliveredOrders': deliveredOrders?.map((e) => e.toJson()).toList(),
        'notDeliveredOrders':
            notDeliveredOrders?.map((e) => e.toJson()).toList(),
      };
}

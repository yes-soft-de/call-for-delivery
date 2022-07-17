import 'package:c4d/module_orders/response/orders_response/datum.dart';

class Data {
  List<DatumOrder>? pendingOrders;
  List<DatumOrder>? hiddenOrders;
  List<DatumOrder>? notDeliveredOrders;
  num? totalOrderCount;

  Data(
      {this.pendingOrders,
      this.hiddenOrders,
      this.notDeliveredOrders,
      this.totalOrderCount});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalOrderCount: json['totalOrderCount'] as num?,
        pendingOrders: (json['pendingOrders'] as List<dynamic>?)
            ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
        hiddenOrders: (json['hiddenOrders'] as List<dynamic>?)
            ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
        notDeliveredOrders: (json['notDeliveredOrders'] as List<dynamic>?)
            ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'pendingOrders': pendingOrders,
        'hiddenOrders': hiddenOrders?.map((e) => e.toJson()).toList(),
        'notDeliveredOrders':
            notDeliveredOrders?.map((e) => e.toJson()).toList(),
      };
}
